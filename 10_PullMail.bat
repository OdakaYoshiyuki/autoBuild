@echo off


:BAT_START



git pull origin master
cscript 11_flagAnalysis.vbs

del "flag.txt"
rename "_flag.txt" "flag.txt"

git commit -a -m "フラグクリア"
git push origin master


:RE_SATRT
rem 5秒待つ
timeout /t 5
GOTO BAT_START
