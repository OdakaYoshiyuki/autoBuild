
Dim rFile     ' ファイル読み込み用
Dim wFile     ' ファイル読み込み用
Dim reqMail
Set FS = WScript.CreateObject("Scripting.FileSystemObject")

Set rfile = FS.OpenTextFile("flag.txt")  'ファイルを開く
Set wfile = FS.CreateTextFile("_flag.txt")  'ファイルを開く
Do Until rfile.AtEndOfStream
	tmpLine = rfile.ReadLine
	
	If tmpLine = "＜メールを送る＞" Then
		reqMail = rfile.ReadLine
		wFile.WriteLine "＜メールを送る＞"
		wFile.WriteLine 0
	Else
		wFile.WriteLine tmpLine
	End If
	
Loop
rFile.Close
wFile.Close


If reqMail = 1 Then
	Set objWShell = CreateObject("Wscript.Shell") 
	objWShell.run "cmd /c 12_sendMail.bat", vbHide
End If


FS.DeleteFile "flag.txt"
Set Fn = FS.GetFile("_flag.txt") 
Fn.Name = "flag.txt"

