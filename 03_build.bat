@echo off
rem まず開発者用コマンドプロンプトを起動してから
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat"

rem PJnaemをsetingファイルから読み込む
(
    SET /P PJ_NAME=
)< setting.txt



rem MSBuildでビルドする(C++)
cd %~dp0
echo SIM 2YJ環境のビルド
MSBuild ..\%PJ_NAME%\project\02YJ\build_sim\TARGET.sln /t:rebuild

if %ERRORLEVEL% neq 0 (
    echo ErrorLevel:%ERRORLEVEL%
    echo ビルド失敗
)

echo SIM 0000環境のビルド
MSBuild ..\%PJ_NAME%\project\0000\build_sim\TARGET.sln /t:rebuild

if %ERRORLEVEL% neq 0 (
    echo ErrorLevel:%ERRORLEVEL%
    echo ビルド失敗
)


rem %~dp0 　⇒　%0にオプション構文の『 ~ 』と『 d 』と『 p 』が付いたものです。
rem ~　　　⇒　(ダブルクオート)を除く
rem %0  実行されているファイルのパスです。 "C:\･･･\･･･\" こんな感じで　ダブルクオートが邪魔になるため、%~0 として


