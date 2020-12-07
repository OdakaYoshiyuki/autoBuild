
cd %~dp0

rem setingƒtƒ@ƒCƒ‹‚©‚ç“Ç‚İ‚Ş
(
    SET /P PJ_NAME=
    SET /P USR_NAME=
    SET /P P4_PASS=
)< setting.txt


p4 set P4PORT=sd-p4-gcp-brkr01.sd.local:1666
p4 set P4CLIENT=%PJ_NAME%
p4 set P4USER=%USR_NAME%
echo %P4_PASS% | p4 login
p4 sync

git pull origin master

call 03_build.bat > result.txt
cscript 04_analysis.vbs
call mail.exe

rem cscript 05_mail.vbs

