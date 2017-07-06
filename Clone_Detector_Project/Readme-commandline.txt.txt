setup and execution instructions :-

0. Have python 2.7 installed and set system path and environment variables. If you have any path or environment variables set to python 3.4, please remove them.
It is recommended that you install python in your C: drive and also have our tool in your C: drive.

First time only 
{

1. After downloading the project folder, please go into the JArchitect5 folder which is located at ...\CloneDetective-master\Clone_Detector_Project\JArchitect5.

2. Click on VisualJArchitect and evaluate your trial license (NOTE: this will not work if you are not connected to the internet)

}

3. Now, please move a built project which has a bin folder and that you wish to analyze into the ...\CloneDetective-master\Clone_Detector_Project\InputProjects folder.

4. Copy the path of the "CloneDetective-master" project folder.

5. Open command prompt and change directory to copied_path_without_space\Clone_Detector_Project\Adapters.

6. Now, copy the path to the project folder of the one that you moved into the ...\CloneDetective-master\Clone_Detector_Project\InputProjects folder.

7. In Command Prompt type,
> python cloneDetective.py path_for_input_project

7. The command prompt will show you the number of clone pairs detected.

8. Also look in the Clone_Detector_Project\Adapters folder for a Results.csv(will be excel if you have excel) which will give method pairs and their final scores, individual scores and metrics used data.

Understanding the Results.csv :-

1. This file contains method pairs, their final score which is the average of the two individual scores which has been calculated using the euclidean distance formula from the metrics gatherd from each tool, the two individual scores, the metrics gathered from the tools.

2. The score indicates the distance between two methods, which means that lesser the distance more the probability that they are a clone pair.

3. In this csv file, we have ordered the results in ascending order. This means that the highest probability clone is at the top and the least probable clone pair is at the bottom most part of the list.