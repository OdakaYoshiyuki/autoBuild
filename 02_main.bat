

git pull origin master


call 03_build.bat > result.txt
cscript 04_analysis.vbs

git commit -a -m "ビルド結果をpush"
git push origin master

pause
