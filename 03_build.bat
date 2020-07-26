@echo off
rem まず開発者用コマンドプロンプトを起動してから
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat"

rem MSBuildでビルドする(C++)
cd %~dp0
MSBuild ..\01_SBL_Xaqro_Printer_odaka_hituji\project\0000\build_sim\TARGET.sln /t:build

if %ERRORLEVEL% neq 0 (
    echo ErrorLevel:%ERRORLEVEL%
    echo ビルド失敗
)

rem %~dp0 　⇒　%0にオプション構文の『 ~ 』と『 d 』と『 p 』が付いたものです。
rem ~　　　⇒　(ダブルクオート)を除く
rem %0  実行されているファイルのパスです。 "C:\･･･\･･･\" こんな感じで　ダブルクオートが邪魔になるため、%~0 として


