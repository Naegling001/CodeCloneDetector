from mppadapter import *
from OutputCombin import *
import os

projectFileName = ".project"

#Method to verify that the ./project file exists in the input project path that was given
def find(name, path):
	files = os.listdir(path)

	if name in files:
		return True

	return False

#Function that validates the input string path that was given by the User
def ValidatePath(path):
	error = ''

	if os.path.isdir(path) == False:
		error = 'INVALID PATH: Please specify a path to a folder.'
	elif ' ' in path:
		error = 'INVALID PATH: Please use a path that does not contain whitespace.'
	elif find(projectFileName, path) == False:
		error = 'INVALID PATH: The input source code folder needs to have an eclipse .project file.'

	return error


if len(sys.argv) > 1:
	print "\npath is = " + sys.argv[1] + "\n"
	print "\n Validating input project... \n"
	message = validationResult = ValidatePath(sys.argv[1])

	if message != '':
		print "\n" + message + "\n"
	else:
		print "\n Validation Complete \n"
		formatted = sys.argv[1].split("\\")
		arrLength = len(formatted)
		pathForMetrix = "..\\" + formatted[arrLength - 2] + "\\" + formatted[arrLength - 1]
		print pathForMetrix
		L1 = get_metrix(pathForMetrix)
		from JArchitectAdapter import *
		L2 = get_jarch_metrices(sys.argv[1])
		CombineAndExportData(L1, L2)
