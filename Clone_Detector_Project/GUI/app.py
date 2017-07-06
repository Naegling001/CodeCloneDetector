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

#from filebrowser import FileBrowser
from kivy.garden.filebrowser import FileBrowser
from kivy.utils import platform

class MainScreen(ScreenManager):
	def __init__(self, **kwargs):
		super(MainScreen, self).__init__(**kwargs)

		#Callback Methods
		def analyzeButtonCallback(instance):
			print('analyze button was pressed')
			self.current = 'Setup'
			
		def exitButtonCallback(instance):
			print('exit button was pressed')

		def browseInputButtonCallback(instance):
			print('browse button was pressed')
			self.current = 'input'

		def fbrowser_canceled(instance):
			print 'cancelled, Close self.'

		def fbrowser_success(instance):
			projectTextInput.text = str(instance.selection)
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
		layout3 = BoxLayout(orientation='vertical')
		browseInputLabel = Label(text='Input Project', halign='center', valign='middle', font_size=72, pos=(5, -10))
		projectTextInput = TextInput(text="path to input project goes here")
		browseInputButton = Button(text='Browse', pos=(450, 100), font_size=14, size_hint = (.2,.1))
		browseInputButton.bind(on_press=browseInputButtonCallback)
		layout4 = BoxLayout(orientation='horizontal')
		layout4.add_widget(browseInputLabel)
		layout4.add_widget(projectTextInput)
		layout4.add_widget(browseInputButton)

		layout3.add_widget(layout4)
		SetupScreen = Screen(name='Setup')
		SetupScreen.add_widget(layout3)


		#InputBrowserScreen
		if platform=='win':
			user_path = dirname(expanduser('~')) + sep + 'Documents'
		else:
			user_path = expanduser('~') + sep + 'Documents'

		InputBrowserScreen = Screen(name='input')
		inputFileBrowser = FileBrowser(select_string='Select', favorites=[(user_path, 'Documents')])
		inputFileBrowser.bind(on_success=fbrowser_success, on_canceled=fbrowser_canceled)
		InputBrowserScreen.add_widget(inputFileBrowser)

		#Status Screen
		StatusScreen = Screen(name='Analysis In Progress')

		#Report Screen
		ReportScreen = Screen(name='Report')

		#Add screens to the screen manager
		self.add_widget(WelcomeScreen)
		self.add_widget(SetupScreen)
		self.add_widget(InputBrowserScreen)
		self.add_widget(StatusScreen)
		self.add_widget(ReportScreen)

		#Set the initial screen
		self.current = 'Welcome'

class TestApp(App):
	def build(self):
		return MainScreen()

if __name__ == '__main__':
	TestApp().run()