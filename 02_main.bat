@echo off

git pull origin master


call 03_build.bat > result.txt
cscript 04_analysis.vbs

rem git push origin master


pause
