@echo off
rem �܂��J���җp�R�}���h�v�����v�g���N�����Ă���
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat"

rem PJnaem��seting�t�@�C������ǂݍ���
(
    SET /P PJ_NAME=
)< setting.txt



rem MSBuild�Ńr���h����(C++)
cd %~dp0
echo SIM 2YJ_Printer �̃r���h
MSBuild ..\%PJ_NAME%\project\02YJ\build_sim\TARGET.sln /p:Configuration=Release_Printer /t:rebuild
if %ERRORLEVEL% neq 0 (
    echo ErrorLevel:%ERRORLEVEL%
    echo �r���h���s
)
echo SIM 2YJ_MFP �̃r���h
MSBuild ..\%PJ_NAME%\project\02YJ\build_sim\TARGET.sln /p:Configuration=Release_MFP /t:rebuild
if %ERRORLEVEL% neq 0 (
    echo ErrorLevel:%ERRORLEVEL%
    echo �r���h���s
)


echo SIM 0000_Printer �̃r���h
MSBuild ..\%PJ_NAME%\project\0000\build_sim\TARGET.sln /p:Configuration=Release_Printer /t:rebuild
if %ERRORLEVEL% neq 0 (
    echo ErrorLevel:%ERRORLEVEL%
    echo �r���h���s
)
echo SIM 0000_MFP �̃r���h
MSBuild ..\%PJ_NAME%\project\0000\build_sim\TARGET.sln /p:Configuration=Release_MFP /t:rebuild
if %ERRORLEVEL% neq 0 (
    echo ErrorLevel:%ERRORLEVEL%
    echo �r���h���s
)


echo Keil 2YJ_Printer���̃r���h
"C:\Keil527\UV4\UV4.exe" UV4 -r ..\%PJ_NAME%\project\02YJ\build_target\TARGET_main\TARGET_main.uvprojx -t release_Printer -l log.txt -j0
type log.txt

echo Keil 2YJ_MFP���̃r���h
"C:\Keil527\UV4\UV4.exe" UV4 -r ..\%PJ_NAME%\project\02YJ\build_target\TARGET_main\TARGET_main.uvprojx -t release_MFP -l log.txt -j0
type log.txt

echo Keil 0000_Printer���̃r���h
"C:\Keil527\UV4\UV4.exe" UV4 -r ..\%PJ_NAME%\project\0000\build_target\TARGET_main\TARGET_main.uvprojx -t release_Printer -l log.txt -j0
type log.txt

echo Keil 0000_MFP���̃r���h
"C:\Keil527\UV4\UV4.exe" UV4 -r ..\%PJ_NAME%\project\0000\build_target\TARGET_main\TARGET_main.uvprojx -t release_MFP -l log.txt -j0
type log.txt


