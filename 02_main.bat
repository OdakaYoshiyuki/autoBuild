
cd %~dp0

rem setingƒtƒ@ƒCƒ‹‚©‚ç“Ç‚İ‚Ş
(
    SET /P PJ_NAME=
    SET /P P4_PASS=
)< setting.txt

echo %P4_PASS% | p4 login
p4 set P4CLIENT=%PJ_NAME%
p4 sync


git pull origin master

call 03_build.bat > result.txt
cscript 04_analysis.vbs
cscript 05_mail.vbs



