@echo off

rem ���݂̈ʒu�Ɉړ�
cd %~dp0

:BAT_START



git pull origin master
cscript 11_flagAnalysis.vbs


git commit -a -m "�t���O�N���A"
git push origin master


rem 18:00�ɂȂ�����I��
rem -----
setlocal ENABLEDELAYEDEXPANSION
echo !TIME!
if "!TIME!" gtr "18:00:00.00" (
	GOTO BAT_END
)
endlocal



:RE_SATRT
rem 5�b�҂�
timeout /t 5
GOTO BAT_START

:BAT_END
