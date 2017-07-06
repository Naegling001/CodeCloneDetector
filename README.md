# CloneDetective
This is a repository for our SWEN-772 SW Quality Engineering Project :)

Setup and Deployment Instructions

This section describes the essential steps to proceed in order to setup and run the software. A detailed instructions are required with screenshots if necessary. 
1.3.1 Main setup instructions:

1) Download “Clone_Detector_Project” named folder on the windows system.

2) Copy the path (make sure not to have space) of that folder on your system.

3) Open command prompt and change directory to copied_path_without_space\Clone_Detector_Project\Adapters

4) To analyze place your compiled JAVA project (with .project file in the root folder) inside <working directory>\Clone_Detector_Project\InputProjects.

5) Try any of the following (a or b):
	a) Double-Click the findclones.bat file located in: <working directory>\Clone_Detector_Project\Adapters
		a.1) Press 1 then ENTER to start analysis.

		a.2) type in (or paste) the absolute path to the input project you wish to analyze located in the InputProjects Folder. For example: C:\Users\User\Desktop\CloneDetective\trunk\Clone_Detector_Project\InputProjects\Cricket-Master

		a.3) Press ENTER and now the tool will start the analysis
		
	b) Now, type 
		> python <path>cloneDetective.py <path_for_input_project>
