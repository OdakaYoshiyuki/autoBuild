@echo off

git pull origin master


call 03_build.bat > result.txt
cscript 04_analysis.vbs
copy 件名.txt ..\..\..\OneDrive\XX_autoMail\odakaBox\件名.txt
copy 本文.txt ..\..\..\OneDrive\XX_autoMail\odakaBox\本文.txt

git push origin master

