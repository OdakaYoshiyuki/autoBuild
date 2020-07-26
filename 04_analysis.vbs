
Dim FS
Dim wFile     ' ファイル書き込み用
Dim rFile     ' ファイル読み込み用
Dim tmpLine
Dim result
Dim preBuildFali
Dim buildFali
Dim reqMail
Set FS = WScript.CreateObject("Scripting.FileSystemObject")

' フラグを読み込む
Set rfile = FS.OpenTextFile("flag.txt")  'ファイルを開く
Do Until rfile.AtEndOfStream
	tmpLine = rfile.ReadLine
	If tmpLine = "＜前回ビルド失敗＞" Then
		preBuildFalier = rfile.ReadLine
	End If
Loop
rFile.Close


reqMail = 0
Set rFile = FS.OpenTextFile("result.txt")  'ファイルを開く
Do Until rFile.AtEndOfStream
	tmpLine = rFile.ReadLine
	If tmpLine = "ビルドに成功しました。" Then
		result = tmpLine
		buildFali = 0
		If preBuildFalier = 1 Then
			reqMail = 1
		End If
	ElseIf tmpLine = "ビルドに失敗しました。" Then
		result = tmpLine
		buildFali = 1
		reqMail = 1
	End If
Loop


WScript.Echo result
Set wFile = FS.OpenTextFile("件名.txt", 2, True)
wFile.WriteLine result
wFile.Close


' フラグを書き込む
Set wFile = FS.OpenTextFile("flag.txt", 2, True)
wFile.WriteLine "＜前回ビルド失敗＞"
wFile.WriteLine buildFali
wFile.WriteLine "＜メールを送る＞"
wFile.WriteLine reqMail


rFile.Close
wFile.Close

WScript.Echo "終了"

