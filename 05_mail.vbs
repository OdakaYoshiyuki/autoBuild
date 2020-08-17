Option Explicit



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
'		メール送信サイトから送信
'--------------------------------------------------------
    Dim objIE
    Dim objLink

    Set objIE = CreateObject("InternetExplorer.Application")
    objIE.Visible = False

    'IEを開く
    objIE.navigate "http://enginesd.php.xdomain.jp/confirm.html"
    
    'ページが読み込まれるまで待つ
    Do While objIE.Busy = True Or objIE.readyState <> 4
        WScript.Sleep 100        
    Loop


    objIE.document.getElementsByName("to")(0).Value = mailTo
    objIE.document.getElementsByName("title")(0).Value = mailSubject
    objIE.document.getElementsByName("content")(0).Value = mailBody


    '送信
    objIE.document.forms(0).submit()


    'ページが読み込まれるまで待つ
    Do While objIE.Busy = True Or objIE.readyState <> 4
        WScript.Sleep 100        
    Loop


    objIE.Quit
    Set objIE = Nothing
