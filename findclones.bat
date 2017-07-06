@echo off
set /p path="Enter path to project:"
set /p threshold="Enter minimum number of lines in a method:"
python JArchitectAdapter.py "%path%"
python mppadapter.py "%path%"
cd..
python OutputCombin.py