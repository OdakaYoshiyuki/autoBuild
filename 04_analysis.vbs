'���O����{�G���[
Dim ignErr(200)
Dim ignNum
ignNum = -1
ignErr(add1(ignNum)) = "SSYSInformationTCCSha256.obj : warning LNK4099: PDB"
ignErr(add1(ignNum)) = "SSYSInformationTCCDriver.obj : warning LNK4099: PDB"
ignErr(add1(ignNum)) = "SSYSInformationTCCController.obj : warning LNK4099: PDB"
ignErr(add1(ignNum)) = "KernelLib.lib"

Dim FS
Dim wFile     ' �t�@�C���������ݗp
Dim rFile     ' �t�@�C���ǂݍ��ݗp
Dim tmpLine
Dim subject
Dim preBuildFali
Dim buildFali
Dim buildFaliNum
Dim buildWarning
Dim buildWarningNum
Dim reqMail
Dim hit
Dim hit2
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
buildFaliNum = 0
buildWarning = 0
buildWarningNum = 0
reqMail = 0
Set rFile = FS.OpenTextFile("result.txt")  '�t�@�C�����J��
Do Until rFile.AtEndOfStream
	tmpLine = rFile.ReadLine
	
	'�G���[��T��
	hit = InStr( tmpLine, ": error" )      '��������
	If hit <> 0 Then
		buildFaliNum = buildFaliNum + 1
		buildFali = 1
		wFile.WriteLine tmpLine
	End If
	'warning��T��
	hit = InStr( tmpLine, ": warning" )      '��������
	If hit <> 0 Then
		hit = ignJudge(tmpLine)		'���O�G���[��hit���Ȃ�������J�E���g
		If hit = 0 Then
			buildWarningNum = buildWarningNum + 1
			buildWarning = 1
			wFile.WriteLine tmpLine
		End If
	End If

	'�G���[�A�x����
	hit = InStr( tmpLine, " �̌x��" )      '��������
	If hit <> 0 Then
		wFile.WriteLine "    " & buildWarningNum & " �̌x��"
		buildWarningNum = 0
		tmpLine = rFile.ReadLine
		wFile.WriteLine "    " & buildFaliNum & " �G���["
		buildFaliNum = 0
	End If

	hit = InStr( tmpLine, "SIM 2YJ_Printer �̃r���h" )      '��������
	If hit <> 0 Then
		wFile.WriteLine "SIM 2YJ_Printer �̃r���h����"
	End If
	hit = InStr( tmpLine, "SIM 2YJ_MFP �̃r���h" )      '��������
	If hit <> 0 Then
		wFile.WriteLine "SIM 2YJ_MFP �̃r���h����"
	End If
	hit = InStr( tmpLine, "SIM 0000_Printer �̃r���h" )      '��������
	If hit <> 0 Then
		wFile.WriteLine ""
		wFile.WriteLine "SIM 0000_Printer �̃r���h����"
	End If
	hit = InStr( tmpLine, "SIM 0000_MFP �̃r���h" )      '��������
	If hit <> 0 Then
		wFile.WriteLine ""
		wFile.WriteLine "SIM 0000_MFP �̃r���h����"
	End If
	hit = InStr( tmpLine, "Keil 2YJ_Printer���̃r���h" )      '��������
	If hit <> 0 Then
		wFile.WriteLine ""
		wFile.WriteLine "Keil 2YJ_Printer���̃r���h����"
	End If
	hit = InStr( tmpLine, "Keil 2YJ_MFP���̃r���h" )      '��������
	If hit <> 0 Then
		wFile.WriteLine ""
		wFile.WriteLine "Keil 2YJ_MFP���̃r���h����"
	End If
	hit = InStr( tmpLine, "Keil 0000_Printer���̃r���h" )      '��������
	If hit <> 0 Then
		wFile.WriteLine ""
		wFile.WriteLine "Keil 0000_Printer���̃r���h����"
	End If
	hit = InStr( tmpLine, "Keil 0000_MFP���̃r���h" )      '��������
	If hit <> 0 Then
		wFile.WriteLine ""
		wFile.WriteLine "Keil 0000_MFP���̃r���h����"
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
	'����
	hit = InStr( tmpLine, "2YJ_1000" )      '��������
	hit2 = InStr( tmpLine, "�̃r���h���������܂���" )      '��������
	If (hit <> 0) and (hit2 <> 0) Then
		wFile.WriteLine tmpLine
		wFile.WriteLine "    " & buildWarningNum & " �̌x��"
		buildWarningNum = 0
		tmpLine = rFile.ReadLine
		wFile.WriteLine "    " & buildFaliNum & " �G���["
		buildFaliNum = 0
	End If
	hit = InStr( tmpLine, "MFP_1000" )      '��������
	hit2 = InStr( tmpLine, "�̃r���h���������܂���" )      '��������
	If (hit <> 0) and (hit2 <> 0) Then
		wFile.WriteLine tmpLine
		wFile.WriteLine "    " & buildWarningNum & " �̌x��"
		buildWarningNum = 0
		tmpLine = rFile.ReadLine
		wFile.WriteLine "    " & buildFaliNum & " �G���["
		buildFaliNum = 0
	End If
Loop

If buildFali = 1 Then
	reqMail = 1
	subject = "�r���h�Ɏ��s���܂����B"
ElseIf buildWarning = 1 Then
	reqMail = 1
	subject = "�r���h�Ōx�����o�Ă��܂��B"
Else
	reqMail = 0
	subject = "�r���h�ɐ������܂���"
End If

If preBuildFalier = 1 Then
	reqMail = 1
End If

reqMail = 1 '�b��


wFile.WriteLine "�ȏ�ł�"
wFile.Close '�{��close


WScript.Echo subject
Set wFile = FS.OpenTextFile("����.txt", 2, True)
wFile.WriteLine subject
wFile.Close


' �t���O����������
Set wFile = FS.OpenTextFile("flag.txt", 2, True)
wFile.WriteLine "[�O��r���h���s]"
wFile.WriteLine buildFali


rFile.Close
wFile.Close

WScript.Echo "�I��"


'-----------SUB�֐�----------------
Function add1(ret)
    ignNum = ignNum+1
    ret = ignNum
    add1 = ret
End Function


Function ignJudge(readLine)
    Dim ign

    ret = 0
    for i=0 to ignNum
        ign = InStr( readline, ignErr(i) )      '��������
        If ign <> 0 Then
		ret = 1
        End If
    next
    ignJudge = ret
End Function


