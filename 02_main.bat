
cd %~dp0

rem seting�t�@�C������ǂݍ���
(
    SET /P PJ_NAME=
    SET /P BUILD_TYPE=
    SET /P P4_SYNC=
    SET /P P4_PASS=
)< setting.txt

if %P4_SYNC% == P4���ŐV�ɂ��� echo %P4_PASS% | p4 login
if %P4_SYNC% == P4���ŐV�ɂ��� p4 set %PJ_NAME%
if %P4_SYNC% == P4���ŐV�ɂ��� p4 sync

git pull origin master

call 03_build.bat > result.txt
cscript 04_analysis.vbs
cscript 05_mail.vbs

rem git commit -a -m "�r���h���ʂ�push"
git commit -m "�r���h���ʂ�push" flag.txt result.txt ����.txt �{��.txt
git push origin master



