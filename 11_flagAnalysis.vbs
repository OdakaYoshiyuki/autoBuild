
Dim rFile     ' �t�@�C���ǂݍ��ݗp
Dim wFile     ' �t�@�C���ǂݍ��ݗp
Dim reqMail
Set FS = WScript.CreateObject("Scripting.FileSystemObject")

Set rfile = FS.OpenTextFile("flag.txt")  '�t�@�C�����J��
Set wfile = FS.CreateTextFile("_flag.txt")  '�t�@�C�����J��
Do Until rfile.AtEndOfStream
	tmpLine = rfile.ReadLine
	
	If tmpLine = "�����[���𑗂遄" Then
		reqMail = rfile.ReadLine
		wFile.WriteLine "�����[���𑗂遄"
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

