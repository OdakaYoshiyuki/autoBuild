@echo off

rem 現在の位置に移動
cd %~dp0

:BAT_START



git pull origin master
cscript 11_flagAnalysis.vbs


git commit -a -m "フラグクリア"
git push origin master


rem 18:00になったら終了
rem -----
setlocal ENABLEDELAYEDEXPANSION
echo !TIME!
if "!TIME!" gtr "18:00:00.00" (
	GOTO BAT_END
)
endlocal



:RE_SATRT
rem 5秒待つ
timeout /t 5
GOTO BAT_START

:BAT_END
