@echo off

git pull origin master


call 03_build.bat > result.txt
cscript 04_analysis.vbs
copy åèñº.txt ..\..\..\OneDrive\XX_autoMail\odakaBox\åèñº.txt
copy ñ{ï∂.txt ..\..\..\OneDrive\XX_autoMail\odakaBox\ñ{ï∂.txt

git push origin master

