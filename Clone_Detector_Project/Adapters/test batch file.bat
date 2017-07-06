@echo off
cd %~dp0
for /f %%p in ('where python') do SET PYTHONPATH=%%p
echo %PYTHONPATH%
set /p path="Enter path to project:"
"%PYTHONPATH%" cloneDetective.py "%path%"
pause