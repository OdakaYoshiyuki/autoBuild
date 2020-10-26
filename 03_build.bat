@echo off
rem まず開発者用コマンドプロンプトを起動してから
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat"

rem PJnaemをsetingファイルから読み込む
(
    SET /P PJ_NAME=
    SET /P BUILD_TYPE=
)< setting.txt



rem MSBuildでビルドする(C++)
cd %~dp0
echo SIM 2YJ_Printer のビルド
MSBuild ..\%PJ_NAME%\project\02YJ\build_sim\TARGET.sln /p:Configuration=Release_Printer /t:rebuild
if %ERRORLEVEL% neq 0 (
    echo ErrorLevel:%ERRORLEVEL%
    echo ビルド失敗
)
echo SIM 2YJ_MFP のビルド
MSBuild ..\%PJ_NAME%\project\02YJ\build_sim\TARGET.sln /p:Configuration=Release_MFP /t:rebuild
if %ERRORLEVEL% neq 0 (
    echo ErrorLevel:%ERRORLEVEL%
    echo ビルド失敗
)


echo SIM 0000_Printer のビルド
MSBuild ..\%PJ_NAME%\project\0000\build_sim\TARGET.sln /p:Configuration=Release_Printer /t:rebuild
if %ERRORLEVEL% neq 0 (
    echo ErrorLevel:%ERRORLEVEL%
    echo ビルド失敗
)
echo SIM 0000_MFP のビルド
MSBuild ..\%PJ_NAME%\project\0000\build_sim\TARGET.sln /p:Configuration=Release_MFP /t:rebuild
if %ERRORLEVEL% neq 0 (
    echo ErrorLevel:%ERRORLEVEL%
    echo ビルド失敗
)

if not %BUILD_TYPE% == Keilでビルドする GOTO BAT_END

echo Keil 2YJ_Printer環境のビルド
"C:\Keil527\UV4\UV4.exe" UV4 -r ..\%PJ_NAME%\project\02YJ\build_target\TARGET_main\TARGET_main.uvprojx -t release_Printer -l log.txt -j0
type log.txt

echo Keil 2YJ_MFP環境のビルド
"C:\Keil527\UV4\UV4.exe" UV4 -r ..\%PJ_NAME%\project\02YJ\build_target\TARGET_main\TARGET_main.uvprojx -t release_MFP -l log.txt -j0
type log.txt

echo Keil 0000_Printer環境のビルド
"C:\Keil527\UV4\UV4.exe" UV4 -r ..\%PJ_NAME%\project\0000\build_target\TARGET_main\TARGET_main.uvprojx -t release_Printer -l log.txt -j0
type log.txt

echo Keil 0000_MFP環境のビルド
"C:\Keil527\UV4\UV4.exe" UV4 -r ..\%PJ_NAME%\project\0000\build_target\TARGET_main\TARGET_main.uvprojx -t release_MFP -l log.txt -j0
type log.txt


:BAT_END

cd %~dp0

rem %~dp0 　⇒　%0にオプション構文の『 ~ 』と『 d 』と『 p 』が付いたものです。
rem ~　　　⇒　(ダブルクオート)を除く
rem %0  実行されているファイルのパスです。 "C:\･･･\･･･\" こんな感じで　ダブルクオートが邪魔になるため、%~0 として

