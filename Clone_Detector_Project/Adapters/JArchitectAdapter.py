#This is the adapter class that handles the interaction with the JArchitect tool.
#You have to pass in the directory path of the source project that you
#want to analyze with the tool.
import subprocess
import xml
import os
import sys
import xml.dom.minidom
import xml.etree.ElementTree as ET
import re
import math
import gc

'''This is how the Columns Node is structured right now 
in the .jdproj file we use.'''
MetricNames = ['methods', 
'FullName', 
'Name', 
'jarchitect:CyclomaticComplexity', 
'MethodsCalled', 
'jarchitect:NbMethodsCalled', 
'MethodsCallingMe', 
'NbMethodsCallingMe', 
'jarchitect:NbParameters', 
'jarchitect:NbVariables', 
'Rank', 
'IsOverloaded', 
'ParentType', 
'ParentProject', 
'ParentPackage']

GlobalMetrics = [ 'jarchitect:CyclomaticComplexity', 
'jarchitect:NbMethodsCalled', 
'jarchitect:NbParameters', 
'jarchitect:NbVariables']

SCORE = 2

#Creates a subprocess with the command to kickoff the JArchitect Analysis.
# inputProjectpath -> path to the input project's folder (source code that will be analyzed).
def RunJArchitect(inputProjectpath):
	# With JArchitect's console interface the only mandatory argument is the path to the .jdproj file.
	# This is the XML file that it uses to run the analysis.
	# This .jdproj file needs to be updated with the path of the input file before executing the analysis.
	command = "JArchitect.Console.exe "

	#Get current path to where the local repo folder is located in the PC.
	#currentDir = os.getcwd()
	currentDir = os.path.dirname(os.path.realpath(__file__))

	#Remove "Adapters" from the path
	currentDir = currentDir[:-8]

	toolPath = currentDir + "JArchitect5\JArchitect_Project.jdproj"
	pathToOutputFolder = currentDir + "JArchitect5\JArchitectOut"
	UpdateConfigFile(toolPath, inputProjectpath, pathToOutputFolder)
	command = command + toolPath

	print "Executing JArchitect....\n"

	result = []
	command2 = "cd " + currentDir + "JArchitect5"
	# On Windows you need to use & between each command...  ; for other OSes
	commands = command2 + "& " + command

	#print "\n\n commands = " + commands + "\n\n";

	p = subprocess.Popen(commands, 
    	shell=True, 
    	stdout=subprocess.PIPE, 
    	stderr=subprocess.PIPE )
	for line in p.stdout:
		result.append(line)
	errcode = p.returncode
	for line in result:
		#Don't show the Warning message which how much days we have left on our trial version...
		if line.split(":")[0] != 'WARNING':
			print(line)

def UpdateConfigFile(pathToXMLFile, inputPath, outputFolderPath):
	tree = ET.parse(pathToXMLFile)
	root = tree.getroot()

	#Update output folder path
	root[0].text = outputFolderPath

	#Update the JArchitect project file with the new input project path before executing the tool.
	check = inputPath.split(".")
	length = len(check)
	if check[length - 1] == "project":
		root[1][0].text = inputPath
		#Remove "\.project" from the path
		root[3][1].text = inputPath[:-9]
	else:
		root[1][0].text = inputPath + "\.project"
		root[3][1].text = inputPath

	#Save the changes
	tree.write(pathToXMLFile)#, encoding="utf-8", xml_declaration=True)
	line_prepender(pathToXMLFile, "<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"yes\"?>")

def line_prepender(filename, line):
    with open(filename, 'r+') as f:
        content = f.read()
        f.seek(0, 0)
        f.write(line.rstrip('\r\n') + '\n' + content)

def ParseXMLData():
	gc.enable()
	listofMethods = []
	pathToXMLFile = os.path.dirname(os.path.realpath(__file__))
	pathToXMLFile = pathToXMLFile[:-8] + "JArchitect5\JArchitectOut\XmlFilesUsedToBuildReport\CodeRuleResult.xml"
	tree = ET.parse(pathToXMLFile)
	root = tree.getroot()

	groupElement = root.findall(".//Query/..[@Name='Code Quality Regression']")
	#Contains the metric names starting from the second item. The first column node is just always 'methods'.
	'''Columns = groupElement[0].findall('.//Column')
	for column in Columns:
		print column.text'''
	#Contains the values per method
	Rows = groupElement[0].findall('.//Row')
	for row in Rows:
		newMethodList = []
		name = row[0].text
		strArray = name.split(".")
		arrLength = len(strArray)

		#Grab the method name in the following format:
		#classname.methodname
		name = strArray[arrLength - 2] + "." + strArray[arrLength - 1]

		if name != '0.0':
			'''print "\n\n--------------------------"
			print "Method Name = " + name'''
			newMethodList.append(name)
			#Cyclomatic Complexity Value
			result = ""
			if row[2].text == 'N/A':
				result = "0"
				newMethodList.append(0)#(MetricNames[3], 0))
			else:
				result = row[2].text
				newMethodList.append(int(row[2].text))#(MetricNames[3],int(row[2].text)))
			'''print "CC = " + result
			print "# of Methods called = " + row[4].text
			print "# of parameters = " + row[7].text
			print "# of variables = " + row[8].text
			print "--------------------------"'''
			#Number of methods called
			newMethodList.append(int(row[4].text))#(MetricNames[5],int(row[4].text)))

			#Number of parameters
			newMethodList.append(int(row[7].text))#(MetricNames[8],int(row[7].text)))

			#Number of variables
			newMethodList.append(int(row[8].text))#(MetricNames[9],int(row[8].text)))

			#Add the new method info into the big list.
			listofMethods.append(newMethodList)
	Rows = []
	gc.collect()
	#listofMethods = listofMethods[0:20]
	return listofMethods

"""
Compares all functions in the list to each other once
"""

def get_comparisons(allFun,threshold):
	SCORE = 2
	allComp = []
	#print('Number of functions found')
	#print(len(allFun))
	largest = 0
	for i in range(len(allFun)):
		for j in range(i+1,len(allFun)-1):
			comp = (compare_functions(allFun[i],allFun[j]))
			if comp[SCORE] > largest:
				largest = comp[SCORE]
			if comp[SCORE] <= threshold:
				allComp.append(comp)
	for i in allComp:
		if threshold > 50:
			normscore = (i[SCORE]/threshold) * 100
    	else:
			normscore = (i[SCORE]/50) * 100
			i[SCORE] = normscore
	return allComp

def compare_functions(fA,fB):
	distance = 0
	pairList = [fA[0],fB[0],distance]
	names = iter(GlobalMetrics)
	for i in range(1,len(fA)):
		pairList.append((names.next(),abs(fA[i]-fB[i])))
		distance = distance + ((fA[i] - fB[i]) ** 2.0)
	pairList[2] = math.sqrt(distance) 
	return pairList

def get_jarch_metrices(pathToProject, threshold=10):
	print "\n\n"
	print "Running JArchitectAdapter Script\n"
	
	RunJArchitect(pathToProject)

	#Parse XML data and load it into the data structure
	print "Parsing Data....\n"
	allmethods = ParseXMLData()
	allComp = get_comparisons(allmethods, threshold);
	#print allComp[0]
	print "----Finished JArchitect Analysis & Parsing! ----"
	return allComp

#Execute Script
#argv[0] = the path to the input directory
if __name__ == '__main__':
	#main()
	if len(sys.argv) > 1:
		a = get_jarch_metrices(sys.argv[1])
		f = open('jarchdata', 'w')
	 	for i in a:
	 		f.write(str(i))
	 		#print(i)
	 	f.close()
