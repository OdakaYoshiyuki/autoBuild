
Dim FS
Dim wFile     ' ファイル書き込み用
Dim rFile     ' ファイル読み込み用
Dim tmpLine
Dim result
Dim preBuildFali
Dim buildFali
Dim reqMail
Dim hit
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

' result.txtを解析して本文を作成
Set wFile = FS.OpenTextFile("本文.txt", 2, True)
wFile.WriteLine "お疲れ様です"
wFile.WriteLine "ESD 小高さんのPCです"
wFile.WriteLine ""
wFile.WriteLine "最新環境ビルドを行いました"
wFile.WriteLine "結果は下記です。"
wFile.WriteLine ""

buildFali = 0
reqMail = 0
Set rFile = FS.OpenTextFile("result.txt")  'ファイルを開く
Do Until rFile.AtEndOfStream
	tmpLine = rFile.ReadLine
	
	'エラーを探索
	hit = InStr( tmpLine, ": error" )      '検索する
	If hit <> 0 Then
		buildFali = 1
		wFile.WriteLine tmpLine
	End If
	'warningを探索
	hit = InStr( tmpLine, ": warning" )      '検索する
	If hit <> 0 Then
		buildFali = 1
		wFile.WriteLine tmpLine
	End If

	'エラー、警告個数
	hit = InStr( tmpLine, " 個の警告" )      '検索する
	If hit <> 0 Then
		wFile.WriteLine tmpLine
		tmpLine = rFile.ReadLine
		wFile.WriteLine tmpLine
	End If

	hit = InStr( tmpLine, "SIM 2YJ環境のビルド" )      '検索する
	If hit <> 0 Then
		wFile.WriteLine "SIM 2YJ環境のビルド結果"
	End If
	hit = InStr( tmpLine, "SIM 0000環境のビルド" )      '検索する
	If hit <> 0 Then
		wFile.WriteLine ""
		wFile.WriteLine "SIM 0000環境のビルド結果"
	End If

	'その他のコメント
	hit = InStr( tmpLine, "ビルドに成功しました。" )      '検索する
	If hit <> 0 Then
		wFile.WriteLine tmpLine
	End If
		'エラーを探索
	hit = InStr( tmpLine, "ビルドに失敗しました。" )      '検索する
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


wFile.WriteLine "以上です"
wFile.Close '本文close


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

