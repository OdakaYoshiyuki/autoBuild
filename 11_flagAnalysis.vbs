
Dim rFile     ' �t�@�C���ǂݍ��ݗp
Dim wFile     ' �t�@�C���ǂݍ��ݗp
Dim reqMail
Set FS = WScript.CreateObject("Scripting.FileSystemObject")


Set rfile = FS.OpenTextFile("flag.txt")  '�t�@�C�����J��
Set wfile = FS.OpenTextFile("_flag.txt")  '�t�@�C�����J��
Do Until rfile.AtEndOfStream
	tmpLine = rfile.ReadLine
	wFile.WriteLine tmpLine
	If tmpLine = "�����[���𑗂遄" Then
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





