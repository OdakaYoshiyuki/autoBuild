



rem ------件名、宛先を読み込んむ----
rem 件名を読み込む
for /f %%a in (件名.txt) do (
  SET subject=%%a
)

rem 宛先を読み込む
for /f %%a in (宛先.txt) do (
  SET destination=%%a
)

copy "本文.txt" ..\smail\mail.txt


cd ..\smail
smail -hsmtp.gmail.com  -fy.odaka.519@gmail.com -s%subject% -Fmail.txt %destination% -d -i


