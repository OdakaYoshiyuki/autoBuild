@echo off


:BAT_START



git pull origin master
cscript 11_flagAnalysis.vbs


git commit -a -m "�t���O�N���A"
git push origin master


:RE_SATRT
rem 5�b�҂�
timeout /t 5
GOTO BAT_START
