'除外する府エラー
Dim ignErr(200)
Dim ignNum
ignNum = -1
ignErr(add1(ignNum)) = "SSYSInformationTCCSha256.obj : warning LNK4099: PDB"
ignErr(add1(ignNum)) = "SSYSInformationTCCDriver.obj : warning LNK4099: PDB"
ignErr(add1(ignNum)) = "SSYSInformationTCCController.obj : warning LNK4099: PDB"
ignErr(add1(ignNum)) = "KernelLib.lib"

Dim FS
Dim wFile     ' ファイル書き込み用
Dim rFile     ' ファイル読み込み用
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
buildFaliNum = 0
buildWarning = 0
buildWarningNum = 0
reqMail = 0
Set rFile = FS.OpenTextFile("result.txt")  'ファイルを開く
Do Until rFile.AtEndOfStream
	tmpLine = rFile.ReadLine
	
	'エラーを探索
	hit = InStr( tmpLine, ": error" )      '検索する
	If hit <> 0 Then
		buildFaliNum = buildFaliNum + 1
		buildFali = 1
		wFile.WriteLine tmpLine
	End If
	'warningを探索
	hit = InStr( tmpLine, ": warning" )      '検索する
	If hit <> 0 Then
		hit = ignJudge(tmpLine)		'除外エラーにhitしなかったらカウント
		If hit = 0 Then
			buildWarningNum = buildWarningNum + 1
			buildWarning = 1
			wFile.WriteLine tmpLine
		End If
	End If

	'エラー、警告個数
	hit = InStr( tmpLine, " 個の警告" )      '検索する
	If hit <> 0 Then
		wFile.WriteLine "    " & buildWarningNum & " 個の警告"
		buildWarningNum = 0
		tmpLine = rFile.ReadLine
		wFile.WriteLine "    " & buildFaliNum & " エラー"
		buildFaliNum = 0
	End If

	hit = InStr( tmpLine, "SIM 2YJ_Printer のビルド" )      '検索する
	If hit <> 0 Then
		wFile.WriteLine "SIM 2YJ_Printer のビルド結果"
	End If
	hit = InStr( tmpLine, "SIM 2YJ_MFP のビルド" )      '検索する
	If hit <> 0 Then
		wFile.WriteLine "SIM 2YJ_MFP のビルド結果"
	End If
	hit = InStr( tmpLine, "SIM 0000_Printer のビルド" )      '検索する
	If hit <> 0 Then
		wFile.WriteLine ""
		wFile.WriteLine "SIM 0000_Printer のビルド結果"
	End If
	hit = InStr( tmpLine, "SIM 0000_MFP のビルド" )      '検索する
	If hit <> 0 Then
		wFile.WriteLine ""
		wFile.WriteLine "SIM 0000_MFP のビルド結果"
	End If
	hit = InStr( tmpLine, "Keil 2YJ_Printer環境のビルド" )      '検索する
	If hit <> 0 Then
		wFile.WriteLine ""
		wFile.WriteLine "Keil 2YJ_Printer環境のビルド結果"
	End If
	hit = InStr( tmpLine, "Keil 2YJ_MFP環境のビルド" )      '検索する
	If hit <> 0 Then
		wFile.WriteLine ""
		wFile.WriteLine "Keil 2YJ_MFP環境のビルド結果"
	End If
	hit = InStr( tmpLine, "Keil 0000_Printer環境のビルド" )      '検索する
	If hit <> 0 Then
		wFile.WriteLine ""
		wFile.WriteLine "Keil 0000_Printer環境のビルド結果"
	End If
	hit = InStr( tmpLine, "Keil 0000_MFP環境のビルド" )      '検索する
	If hit <> 0 Then
		wFile.WriteLine ""
		wFile.WriteLine "Keil 0000_MFP環境のビルド結果"
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
	'完了
	hit = InStr( tmpLine, "2YJ_1000" )      '検索する
	hit2 = InStr( tmpLine, "のビルドが完了しました" )      '検索する
	If (hit <> 0) and (hit2 <> 0) Then
		wFile.WriteLine tmpLine
		wFile.WriteLine "    " & buildWarningNum & " 個の警告"
		buildWarningNum = 0
		tmpLine = rFile.ReadLine
		wFile.WriteLine "    " & buildFaliNum & " エラー"
		buildFaliNum = 0
	End If
	hit = InStr( tmpLine, "MFP_1000" )      '検索する
	hit2 = InStr( tmpLine, "のビルドが完了しました" )      '検索する
	If (hit <> 0) and (hit2 <> 0) Then
		wFile.WriteLine tmpLine
		wFile.WriteLine "    " & buildWarningNum & " 個の警告"
		buildWarningNum = 0
		tmpLine = rFile.ReadLine
		wFile.WriteLine "    " & buildFaliNum & " エラー"
		buildFaliNum = 0
	End If
Loop

If buildFali = 1 Then
	reqMail = 1
	subject = "ビルドに失敗しました。"
ElseIf buildWarning = 1 Then
	reqMail = 1
	subject = "ビルドで警告が出ています。"
Else
	reqMail = 0
	subject = "ビルドに成功しました"
End If

If preBuildFalier = 1 Then
	reqMail = 1
End If

reqMail = 1 '暫定


wFile.WriteLine "以上です"
wFile.Close '本文close


WScript.Echo subject
Set wFile = FS.OpenTextFile("件名.txt", 2, True)
wFile.WriteLine subject
wFile.Close


' フラグを書き込む
Set wFile = FS.OpenTextFile("flag.txt", 2, True)
wFile.WriteLine "[前回ビルド失敗]"
wFile.WriteLine buildFali


rFile.Close
wFile.Close

WScript.Echo "終了"


'-----------SUB関数----------------
Function add1(ret)
    ignNum = ignNum+1
    ret = ignNum
    add1 = ret
End Function


Function ignJudge(readLine)
    Dim ign

    ret = 0
    for i=0 to ignNum
        ign = InStr( readline, ignErr(i) )      '検索する
        If ign <> 0 Then
		ret = 1
        End If
    next
    ignJudge = ret
End Function


