
cd %~dp0
git pull origin master


call 03_build.bat > result.txt
cscript 04_analysis.vbs


rem git commit -a -m "�r���h���ʂ�push"
git commit -m "�r���h���ʂ�push" flag.txt ����.txt result.txt ����.txt �{��.txt
git push origin master

