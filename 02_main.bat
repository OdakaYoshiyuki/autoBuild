
cd %~dp0

rem seting�t�@�C������ǂݍ���
(
    SET /P PJ_NAME=
    SET /P BUILD_TYPE=
    SET /P MAIL_TYPE=
)< setting.txt



git pull origin master

call 03_build.bat > result.txt
cscript 04_analysis.vbs

rem git commit -a -m "�r���h���ʂ�push"
git commit -m "�r���h���ʂ�push" flag.txt ����.txt result.txt ����.txt �{��.txt
git push origin master

if %MAIL_TYPE% == �r���h���ʂ�outlook�Ń��[�����M cscript 20_sendOutLookMail.vbs

pause

