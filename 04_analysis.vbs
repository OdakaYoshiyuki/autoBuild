
Dim FS
Dim wFile     ' �t�@�C���������ݗp
Dim rFile     ' �t�@�C���ǂݍ��ݗp
Dim tmpLine
Dim result
Dim preBuildFali
Dim buildFali
Dim reqMail
Dim hit
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

' result.txt����͂��Ė{�����쐬
Set wFile = FS.OpenTextFile("�{��.txt", 2, True)
wFile.WriteLine "�����l�ł�"
wFile.WriteLine "ESD ���������PC�ł�"
wFile.WriteLine ""
wFile.WriteLine "�ŐV���r���h���s���܂���"
wFile.WriteLine "���ʂ͉��L�ł��B"
wFile.WriteLine ""

buildFali = 0
reqMail = 0
Set rFile = FS.OpenTextFile("result.txt")  '�t�@�C�����J��
Do Until rFile.AtEndOfStream
	tmpLine = rFile.ReadLine
	
	'�G���[��T��
	hit = InStr( tmpLine, ": error" )      '��������
	If hit <> 0 Then
		buildFali = 1
		wFile.WriteLine tmpLine
	End If
	'warning��T��
	hit = InStr( tmpLine, ": warning" )      '��������
	If hit <> 0 Then
		buildFali = 1
		wFile.WriteLine tmpLine
	End If

	'�G���[�A�x����
	hit = InStr( tmpLine, " �̌x��" )      '��������
	If hit <> 0 Then
		wFile.WriteLine tmpLine
		tmpLine = rFile.ReadLine
		wFile.WriteLine tmpLine
	End If

	hit = InStr( tmpLine, "SIM 2YJ���̃r���h" )      '��������
	If hit <> 0 Then
		wFile.WriteLine "SIM 2YJ���̃r���h����"
	End If
	hit = InStr( tmpLine, "SIM 0000���̃r���h" )      '��������
	If hit <> 0 Then
		wFile.WriteLine ""
		wFile.WriteLine "SIM 0000���̃r���h����"
	End If

	'���̑��̃R�����g
	hit = InStr( tmpLine, "�r���h�ɐ������܂����B" )      '��������
	If hit <> 0 Then
		wFile.WriteLine tmpLine
	End If
		'�G���[��T��
	hit = InStr( tmpLine, "�r���h�Ɏ��s���܂����B" )      '��������
	If hit <> 0 Then
		wFile.WriteLine tmpLine
	End If
Loop

If buildFali = 1 Then
	reqMail = 1
End If
If preBuildFalier = 1 Then
	reqMail = 1
End If


wFile.WriteLine "�ȏ�ł�"
wFile.Close '�{��close


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

