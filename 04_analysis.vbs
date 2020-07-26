
Dim FS
Dim file
Dim wFile     ' ファイル書き込み用
Dim tmpLine
Dim result
Set FS = WScript.CreateObject("Scripting.FileSystemObject")
Set file = FS.OpenTextFile("result.txt")  'ファイルを開く



Do Until file.AtEndOfStream
	tmpLine = file.ReadLine
	If tmpLine = "ビルドに成功しました。" Then
		result = tmpLine
	ElseIf tmpLine = "ビルドに失敗しました。" Then
		result = tmpLine
	End If
Loop


WScript.Echo result
Set wFile = FS.OpenTextFile("件名.txt", 2, True)
wFile.WriteLine result


file.Close
wFile.Close

WScript.Echo "終了"

