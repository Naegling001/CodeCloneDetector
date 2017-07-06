@echo off
cd %~dp0
echo %~dp0
echo is your current directory.
for /f %%p in ('where python.exe') do SET PYTHONPATH=%%p
echo %PYTHONPATH% is detected as the location of your python.exe.

echo enter "1" if you want to start analysis.
echo enter "2" is you want to exit.
set /p choice=
IF /i "%choice%"=="1" goto option1
IF /i "%choice%"=="2" goto option2

echo Invalid Option.
goto :izanagi

:izanagi
echo enter "1" if you want to start analysis.
echo enter "2" is you want to exit.
set /p choice=
IF /i "%choice%"=="1" goto option1
IF /i "%choice%"=="2" goto option2
echo Invalid Option.
goto :izanagi

:option1
set /p path="Enter path to project:"
"%PYTHONPATH%" cloneDetective.py "%path%"
echo "PLEASE PRESS ENTER FOR CSV TO OPEN."
pause
echo "Please check the results.csv for details of method clones and save it by giving it your desired name using the save-as option."

echo "PLEASE WAIT FOR THE RESULTS TO OPEN."
START %~dp0/Results.csv
pause
goto :izanagi 


:option2
commonexit