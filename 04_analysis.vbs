
Dim FS
Dim wFile     ' �t�@�C���������ݗp
Dim rFile     ' �t�@�C���ǂݍ��ݗp
Dim tmpLine
Dim result
Dim preBuildFali
Dim buildFali
Dim reqMail
Set FS = WScript.CreateObject("Scripting.FileSystemObject")

' �t���O��ǂݍ���
Set rfile = FS.OpenTextFile("flag.txt")  '�t�@�C�����J��
Do Until rfile.AtEndOfStream
	tmpLine = rfile.ReadLine
	If tmpLine = "���O��r���h���s��" Then
		preBuildFalier = rfile.ReadLine
	End If
Loop
rFile.Close


reqMail = 0
Set rFile = FS.OpenTextFile("result.txt")  '�t�@�C�����J��
Do Until rFile.AtEndOfStream
	tmpLine = rFile.ReadLine
	If tmpLine = "�r���h�ɐ������܂����B" Then
		result = tmpLine
		buildFali = 0
		If preBuildFalier = 1 Then
			reqMail = 1
		End If
	ElseIf tmpLine = "�r���h�Ɏ��s���܂����B" Then
		result = tmpLine
		buildFali = 1
		reqMail = 1
	End If
Loop


WScript.Echo result
Set wFile = FS.OpenTextFile("����.txt", 2, True)
wFile.WriteLine result
wFile.Close


' �t���O����������
Set wFile = FS.OpenTextFile("flag.txt", 2, True)
wFile.WriteLine "���O��r���h���s��"
wFile.WriteLine buildFali
wFile.WriteLine "�����[���𑗂遄"
wFile.WriteLine reqMail


rFile.Close
wFile.Close

WScript.Echo "�I��"

