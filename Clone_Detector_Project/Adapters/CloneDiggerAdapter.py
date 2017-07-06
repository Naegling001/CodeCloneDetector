#This is the adapter class that handles the interaction with the CloneDigger tool.
#You have to pass in the directory path of the source project that you
#want to analyze with the tool.

import subprocess
import xml
import os
import sys

def RunCloneDigger(path):
	command = "python clonedigger.py --language=java --size-threshold=10 --cpd-output -o clonedigger2.xml "

	currentDir = os.getcwd()
	currentDir = currentDir[:-8]

	toolSubDir = currentDir + "CloneDigger\clonedigger"
	command = command + path;

	print "Executing CloneDigger...."

	result = []
	command2 = "cd " + toolSubDir
	commands = command2 + "& " + command

	print "\n\n commands = " + commands + "\n\n";

	p = subprocess.Popen(commands, 
    	shell=True, 
    	stdout=subprocess.PIPE, 
    	stderr=subprocess.PIPE )
	for line in p.stdout:
		result.append(line)
	errcode = p.returncode
	for line in result:
		print(line)

def main(pathToProject):
	print "\n\n"
	print "Running CloneDiggerAdapter Script"
	print "\n\n pathToProject = " + pathToProject + "\n\n";
	#Execute Clone Digger
	RunCloneDigger(pathToProject)

	#Parse XML data and load it into the data structure
	#LoadXMLData("")

	print "----end of function----"

#def LoadXMLData(pathToXMLFile):
	#TODO

#Execute Script
#argv[0] = the path to the input directory
main(sys.argv[1])
