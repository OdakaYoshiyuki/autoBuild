
Dim FS
Dim file
Dim wFile     ' �t�@�C���������ݗp
Dim tmpLine
Dim result
Set FS = WScript.CreateObject("Scripting.FileSystemObject")
Set file = FS.OpenTextFile("result.txt")  '�t�@�C�����J��



Do Until file.AtEndOfStream
	tmpLine = file.ReadLine
	If tmpLine = "�r���h�ɐ������܂����B" Then
		result = tmpLine
	ElseIf tmpLine = "�r���h�Ɏ��s���܂����B" Then
		result = tmpLine
	End If
Loop


WScript.Echo result
Set wFile = FS.OpenTextFile("����.txt", 2, True)
wFile.WriteLine result


file.Close
wFile.Close

WScript.Echo "�I��"

