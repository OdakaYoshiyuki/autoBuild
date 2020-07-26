@echo off


:BAT_START



git pull origin master
cscript 11_flagAnalysis.vbs

del "flag.txt"
rename "_flag.txt" "flag.txt"

:RE_SATRT
rem 5•b‘Ò‚Â
timeout /t 5
GOTO BAT_START
