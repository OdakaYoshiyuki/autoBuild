
Dim rFile     ' ファイル読み込み用
Dim wFile     ' ファイル読み込み用
Dim reqMail
Set FS = WScript.CreateObject("Scripting.FileSystemObject")


Set rfile = FS.OpenTextFile("flag.txt")  'ファイルを開く
Set wfile = FS.OpenTextFile("_flag.txt")  'ファイルを開く
Do Until rfile.AtEndOfStream
	tmpLine = rfile.ReadLine
	wFile.WriteLine tmpLine
	If tmpLine = "＜メールを送る＞" Then
		reqMail = rfile.ReadLine
	End If
	wFile.WriteLine 0
Loop
rFile.Close
wFile.Close


If reqMail = 1 Then
	Set objWShell = CreateObject("Wscript.Shell") 
	objWShell.run "cmd /c 12_sendMail.bat", vbHide
EndIf





