



rem ------�����A�����ǂݍ����----
rem ������ǂݍ���
for /f %%a in (����.txt) do (
  SET subject=%%a
)

rem �����ǂݍ���
for /f %%a in (����.txt) do (
  SET destination=%%a
)

copy "�{��.txt" ..\smail\mail.txt


cd ..\smail
smail -hsmtp.gmail.com  -fy.odaka.519@gmail.com -s%subject% -Fmail.txt %destination% -d -i


