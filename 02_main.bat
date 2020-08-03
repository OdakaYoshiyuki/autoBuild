
cd %~dp0

rem setingファイルから読み込む
(
    SET /P PJ_NAME=
    SET /P BUILD_TYPE=
    SET /P MAIL_TYPE=
    SET /P P4_SYNC=
)< setting.txt

if %P4_SYNC% == P4を最新にする p4 set %PJ_NAME%
if %P4_SYNC% == P4を最新にする p4 sync

git pull origin master

call 03_build.bat > result.txt
cscript 04_analysis.vbs

rem git commit -a -m "ビルド結果をpush"
git commit -m "ビルド結果をpush" flag.txt 宛先.txt result.txt 件名.txt 本文.txt
git push origin master

if %MAIL_TYPE% == ビルド結果をoutlookでメール送信 cscript 20_sendOutLookMail.vbs

pause

