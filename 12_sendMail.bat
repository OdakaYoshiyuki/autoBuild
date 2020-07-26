



rem ------Œ–¼Aˆ¶æ‚ğ“Ç‚İ‚ñ‚Ş----
rem Œ–¼‚ğ“Ç‚İ‚Ş
for /f %%a in (Œ–¼.txt) do (
  SET subject=%%a
)

rem ˆ¶æ‚ğ“Ç‚İ‚Ş
for /f %%a in (ˆ¶æ.txt) do (
  SET destination=%%a
)

copy "–{•¶.txt" ..\smail\mail.txt


cd ..\smail
smail -hsmtp.gmail.com  -fy.odaka.519@gmail.com -s%subject% -Fmail.txt %destination% -d -i


