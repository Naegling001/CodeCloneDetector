setup and execution instructions :-

First time only 
{

1. After downloading the project folder, please go into the JArchitect5 folder.

2. Click on VisualJArchitect and evaluate your trial license (NOTE: this will not work if you are not connected to the internet)

}

3. Now, please move a built project with the bin folder which you wish to analyze into the InputProjects folder.

4. Copy the path of the Clone detector(make sure not to have space) of that folder on your system.

5. Open command prompt and change directory to copied_path_without_space\Clone_Detector_Project\Adapters

6. Now, type 
> python cloneDetective.py path_for_input_project

7. The command prompt will show you the number of clone pairs detected.

8. Also look in the Clone_Detector_Project\Adapters folder for a Results.csv(will be excel if you have excel) which will give method pairs and their final scores, individual scores and metrics used data.