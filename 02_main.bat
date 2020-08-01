
cd %~dp0
git pull origin master


call 03_build.bat > result.txt
cscript 04_analysis.vbs


rem git commit -a -m "ビルド結果をpush"
git commit -m "ビルド結果をpush" flag.txt 宛先.txt result.txt 件名.txt 本文.txt
git push origin master

