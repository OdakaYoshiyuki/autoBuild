Option Explicit

'--------------------------------------------------------
'		VBSからOutlook起動
'--------------------------------------------------------
    Dim oApp        'As Outlook.Application OutlookのApplication オブジェクトを入れる
    Dim myNameSpace 'As Outlook.NameSpace 名前のスペースと言われても、、
    Dim myFolder    'As Outlook.Folder フォルダー指定

    Set oApp = CreateObject("Outlook.Application")	'outlook 起動をCreateObjectで ※これだと複数起動してしまうがご勘弁を
    Set myNameSpace = oApp.GetNamespace("MAPI")		'呪文１ 名前空間 の 指定 と言っても、.GetNamespace("MAPI")しただけ
    
    '次は作業フォルダーの指定(.GetDefaultFolder) と 表示(.Display)
    Set myFolder = myNameSpace.GetDefaultFolder(6) '規定のフォルダー olFolderInbox=6 指定
    myFolder.Display  '表示 いつものクセで .Visible = True とやりがちだけど

    '通常サイズ olNormalWindow=2 で表示(ほかに olMaximized=0,olMinimized=1)
    oApp.ActiveWindow.WindowState = 2   'olNormalWindow=2 を セット


'--------------------------------------------------------
'		メール内容読み込み
'--------------------------------------------------------
Dim FS
Dim rFile     ' ファイル読み込み用
Dim mailBody, mailSubject, mailTo, mailAttachment

Set FS = WScript.CreateObject("Scripting.FileSystemObject")
' 件名を読み込む
Set rfile = FS.OpenTextFile("件名.txt")  'ファイルを開く
mailSubject = rfile.ReadLine
rFile.Close
' 宛先を読み込む
Set rfile = FS.OpenTextFile("宛先.txt")  'ファイルを開く
mailTo = rfile.ReadLine
rFile.Close

' 本文を読み込む
Set rFile = FS.OpenTextFile("本文.txt")  'ファイルを開く
Do Until rFile.AtEndOfStream
	mailBody = mailBody & rFile.ReadLine & vbCrLf
Loop

'--------------------------------------------------------
'		メール送信
'--------------------------------------------------------
Dim olk, item
Set olk = CreateObject("Outlook.Application")
Set item = olk.CreateItem(0)


item.To = mailTo
item.Subject = mailSubject
item.Body = mailBody
'item.Attachments.Add mailAttachment
item.Display
item.Send


'--------------------------------------------------------
'		終了処理
'--------------------------------------------------------
Set item = Nothing
Set olk = Nothing
WScript.Quit 0

'終了確認 vbYesNo=4 で はいといいえを聞き、
If MsgBox("アウトルックを終了しますか？", 4) = 6 Then   ' vbYes=6[はい]だったら閉じる
	oApp.Quit    'アウトルックを終了する
End If

