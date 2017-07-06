import kivy
kivy.require('1.0.6') # replace with your current kivy version !

import sys
import subprocess
import os
from os.path import sep, expanduser, isdir, dirname

from kivy.app import App
from kivy.base import runTouchApp
from kivy.uix.label import Label
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.textinput import TextInput
from kivy.uix.button import Button
from kivy.uix.screenmanager import ScreenManager, Screen, SlideTransition, NoTransition
from kivy.lang import Builder
from kivy.factory import Factory
from kivy.properties import ObjectProperty, StringProperty
from kivy.uix.popup import Popup

from kivy.garden.filebrowser import FileBrowser
from kivy.utils import platform

from mppadapter import *
from OutputCombin import *
from JArchitectAdapter import *

class MainScreen(ScreenManager):
	def __init__(self, **kwargs):
		super(MainScreen, self).__init__(**kwargs)

		#Main Methods
		def RunAnalysis():
			formatted = projectTextInput.text.split("[u'")[1]
			formatted = formatted.split("']")[0]
			pathForJArchitect = formatted
			print "\n\n" + "pathForJArchitect = "+ pathForJArchitect + "\n\n"
			formatted = formatted.split("\\")
			arrLength = len(formatted)
			#print formatted
			#print "\n\n"
			pathForMetrix = "..\\" + formatted[arrLength - 5] + "\\" + formatted[arrLength - 3]
			print "\n\n" + "pathForMetrix = "+ pathForMetrix + "\n\n"
			statusLabel.text = "Running Metrix++..."
			print "Running Metrix++..."
			L1 = get_metrix(pathForMetrix)

			statusLabel.text = "Running JArchitect..."
			print "Running JArchitect..."
			L2 = get_jarch_metrices(pathForJArchitect)

			statusLabel.text = "Parsing Data..."
			print "Parsing Data..."
			CombineAndExportData(L1, L2)

			statusLabel.text = "Analysis Complete!"
			print "Analysis Complete!"

		#Callback Methods
		def analyzeButtonCallback(instance):
			print('analyze button was pressed')
			self.current = 'Setup'
			
		def exitButtonCallback(instance):
			print('exit button was pressed')

		def browseInputButtonCallback(instance):
			print('browse button was pressed')
			self.current = 'inputscreen'

		def browseOutputButtonCallback(instance):
			self.current = 'outputscreen'

		def runButtonCallback(instance):
			self.current = 'status'
			RunAnalysis()

		def viewReportButtonCallback(instance):
			print "View Report Button Pressed"

		def fbrowser_canceled(instance):
			print 'cancelled, Close self.'

		def fbrowser_success(instance):
			projectTextInput.text = str(instance.selection)
			self.current = 'Setup'

		def outfbrowser_success(instance):
			outputPathTextInput.text = str(instance.selection)
			self.current = 'Setup'

		self.transition = NoTransition()

		#Labels
		welcomeLabel = Label(text='Clone Detective', halign='center', font_size=72, pos=(5, -10))

		#Buttons
		analyzeButton = Button(text='New Analysis', pos=(170, 100), font_size=14, size_hint = (.2,.1))
		analyzeButton.bind(on_press=analyzeButtonCallback)

		exitButton = Button(text='Exit', pos=(450, 100), font_size=14, size_hint = (.2,.1))
		exitButton.bind(on_press=exitButtonCallback)

		#Welcome screen
		layout = BoxLayout(orientation='vertical')
		layout2 = BoxLayout(orientation='horizontal')

		layout.add_widget(welcomeLabel)
		layout2.add_widget(analyzeButton)
		layout2.add_widget(exitButton)
		layout.add_widget(layout2)

		WelcomeScreen = Screen(name='Welcome')
		WelcomeScreen.add_widget(layout)

		#Setup screen
		#Main Layout for the setup screen
		mainSetupLayout = BoxLayout(orientation='vertical')

		#Layout that contains the widgets for the input project
		browseInputLabel = Label(text='Input Project', halign='center', valign='middle', font_size=24)#, pos=(5, -10))
		projectTextInput = TextInput(text="path to input project goes here")
		browseInputButton = Button(text='Browse', pos=(450, 100), font_size=14, size_hint = (.2,.1))
		browseInputButton.bind(on_press=browseInputButtonCallback)
		inputlayout = BoxLayout(orientation='horizontal')
		inputlayout.add_widget(browseInputLabel)
		inputlayout.add_widget(projectTextInput)
		inputlayout.add_widget(browseInputButton)

		"""#Layout that contains the widgets for the output project
		browseOutputLabel = Label(text='Output Folder', halign='center', valign='middle', font_size=24)
		outputPathTextInput = TextInput(text="path to where we will create the report .csv file")
		browseOutputButton = Button(text='Browse', pos=(450, 100), font_size=14, size_hint = (.2,.1))
		browseOutputButton.bind(on_press=browseOutputButtonCallback)
		outputlayout = BoxLayout(orientation='horizontal')
		outputlayout.add_widget(browseOutputLabel)
		outputlayout.add_widget(outputPathTextInput)
		outputlayout.add_widget(browseOutputButton)"""

		#Last but not least....the run button!
		runButton = Button(text='RUN', pos=(450, 100), font_size=14)
		runButton.bind(on_press=runButtonCallback)

		mainSetupLayout.add_widget(inputlayout)
		#mainSetupLayout.add_widget(outputlayout)
		mainSetupLayout.add_widget(runButton)

		#Add the mainSetupLayout to the Setup Screen
		SetupScreen = Screen(name='Setup')
		SetupScreen.add_widget(mainSetupLayout)


		#InputBrowserScreen
		if platform=='win':
			user_path = dirname(expanduser('~')) + sep + 'Documents'
		else:
			user_path = expanduser('~') + sep + 'Documents'

		InputBrowserScreen = Screen(name='inputscreen')
		inputFileBrowser = FileBrowser(select_string='Select', favorites=[(user_path, 'Documents')])
		inputFileBrowser.bind(on_success=fbrowser_success, on_canceled=fbrowser_canceled)
		InputBrowserScreen.add_widget(inputFileBrowser)

		OutputBrowserScreen = Screen(name='outputscreen')
		OutputFileBrowser = FileBrowser(select_string='Select', favorites=[(user_path, 'Documents')])
		OutputFileBrowser.bind(on_success=outfbrowser_success, on_canceled=fbrowser_canceled)
		OutputBrowserScreen.add_widget(OutputFileBrowser)

		#Status Screen
		statusLabel = Label(text='Starting Analysis....', halign='center', font_size=72, pos=(5, -10))	
		reportButton = Button(text='View Report', pos=(170, 100), font_size=14)
		reportButton.bind(on_press=viewReportButtonCallback)
		statusMainLayout = BoxLayout(orientation='vertical')
		statusSubLayout = BoxLayout(orientation='horizontal')

		statusMainLayout.add_widget(statusLabel)
		statusMainLayout.add_widget(reportButton)

		StatusScreen = Screen(name='status')
		StatusScreen.add_widget(statusMainLayout)

		#Add screens to the screen manager
		self.add_widget(WelcomeScreen)
		self.add_widget(SetupScreen)
		self.add_widget(StatusScreen)

		self.add_widget(InputBrowserScreen)
		self.add_widget(OutputBrowserScreen)

		#Set the initial screen
		self.current = 'Welcome'

class TestApp(App):
	def build(self):
		return MainScreen()

if __name__ == '__main__':
	TestApp().run()