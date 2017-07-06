import kivy
kivy.require('1.0.6') # replace with your current kivy version !

import sys
import subprocess
import os

from kivy.app import App
from kivy.base import runTouchApp
from kivy.uix.label import Label
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.textinput import TextInput
from kivy.uix.button import Button
from kivy.uix.screenmanager import ScreenManager, Screen, SlideTransition, SwapTransition
from kivy.lang import Builder
from kivy.factory import Factory
from kivy.properties import ObjectProperty, StringProperty
from kivy.uix.popup import Popup

from filebrowser import FileBrowser

class LoadDialog(FloatLayout):
	load = ObjectProperty(None)
	cancel = ObjectProperty(None)

class MainScreen(Screen):
	pass

class SetupScreen(Screen):
	pass

class StatusScreen(Screen):
	pass

class ReportScreen(Screen):
	pass

class myTextInput(TextInput):
	pass

class InputBrowserScreen(Screen):
	pass
class OutputBrowserScreen(Screen):
	pass

def ValidatePath(path):
	print path

caca = "lalalalala"
firsTime = True

#Reference: https://kivy.org/docs/api-kivy.uix.filechooser.html
class AppScreenManager(ScreenManager):
	#inputProjectPath = StringProperty("type path to the input project here", allownone=False)
	#outputProjectPath = StringProperty("path where we will save the report",  allownone=False)

	inputTextBox = TextInput(text="test")
	outputTextBox = TextInput(text="testing")

	def fbrowser_canceled(self, instance):
		print 'cancelled, Close self.'

	def fbrowser_success(self, instance):
		#self.inputTextBox = str(instance.selection)
		#myTextInput.text = str(instance.selection)
		#self.ids["input_box"].text = "I did this from the script"
		#ValidatePath(self.inputProjectPath)
		self.current = 'Setup'

	def outputfbrowser_success(self, instance):
		caca = str(instance.selection)
		#ValidatePath(self.outputProjectPath)
		self.current = 'Setup'

	def OnEnterSetupScreen(self, instance):
		print "Called on enter"
		if firsTime:
			print "setting to false"
			firstTime = False
		else:
			print "got to the else"
			print "filename = " + self.ids["inputbrowserscreen"].ids["inputbrowser"].filename
		instance.ids["input_box"].text = caca

root_widget = Builder.load_string('''
#:import NoTransition kivy.uix.screenmanager.NoTransition
AppScreenManager:
	transition: NoTransition()
	MainScreen:
	SetupScreen:
	StatusScreen:
	ReportScreen:
	InputBrowserScreen:
	OutputBrowserScreen:

<MainScreen>
	name: 'Main'
	BoxLayout:
		orientation: 'vertical'
		Label:
			size: self.texture_size
			text: 'Clone Detective'
			outline_color: [2, 3, 4]
			font_size: 72
			halign: 'center'
			valign: 'middle'			
		BoxLayout:
			orientation: 'horizontal'
			Button:
				id: 'analysisButton'
				text:'New Analysis'
				font_size: 34
				size_hint: (.2,.5)
				on_release: app.root.current = 'Setup'
			Button:
				id: 'exitButton'
				text:'Exit'
				font_size: 34
				size_hint: (.2,.5)

<SetupScreen>
	name: 'Setup'
	id: setupscreen
	on_enter: app.root.OnEnterSetupScreen(self)
	BoxLayout:
		orientation: 'vertical'
		BoxLayout:
			orientation: 'horizontal'
			Label:
				size: self.texture_size
				text: 'Project'
				font_size: 14
				halign: 'center'
				valign: 'middle'				
			TextInput:
				id: input_box
			Button:
				id: browseButton1
				text: 'Browse'
				font_size: 34
				on_release: app.root.current = 'InputBrowserScreen'
		BoxLayout:
			orientation: 'horizontal'
			Label:
				size: self.texture_size
				text: 'Output'
				font_size: 14
				halign: 'center'
				valign: 'middle'				
			TextInput:
				id: outputTextBox
			Button:
				id: browseButton2
				text: 'Browse'
				font_size: 34
				on_release: app.root.current = 'OutputBrowserScreen'				
		BoxLayout:
			orientation: 'horizontal'
			Button:
				id: 'runButton'
				text:'Run Analysis'
				font_size: 34
				size_hint: (.2,.5)
				on_release: app.root.current = 'Status'

<StatusScreen>
	name: 'Status'
	BoxLayout:
		orientation: 'vertical'	
		Label:
			size: self.texture_size
			text: 'Yo I need status'
			outline_color: [2, 3, 4]
			font_size: 72
			halign: 'center'
			valign: 'middle'
		Button:
			id: 'viewReportButton'
			text:'View Report'
			font_size: 34
			on_release: app.root.current = 'Report'

<ReportScreen>
	name: 'Report'
	Label:
		size: self.texture_size
		text: 'This is your results'
		outline_color: [2, 3, 4]
		font_size: 72
		halign: 'center'
		valign: 'middle'

<InputBrowserScreen>
	id: inputbrowserscreen
	name: 'InputBrowserScreen'
	FileBrowser: 
		id: inputbrowser
		on_canceled: app.root.current = 'Setup'
		on_success: app.root.fbrowser_success(self)

<OutputBrowserScreen>
	name: 'OutputBrowserScreen'
	FileBrowser: 
		id: outputbrowser
		on_canceled: app.root.current = 'Setup'
		on_success: app.root.outputfbrowser_success(self)
''')

class ScreenManagerApp(App):
    def build(self):
        return root_widget

ScreenManagerApp().run()