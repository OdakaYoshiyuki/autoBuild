@echo off

git pull origin master


call 03_build.bat > result.txt
cscript 04_analysis.vbs
copy ����.txt ..\..\..\OneDrive\XX_autoMail\odakaBox\����.txt
copy �{��.txt ..\..\..\OneDrive\XX_autoMail\odakaBox\�{��.txt

git push origin master

