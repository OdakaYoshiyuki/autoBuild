Option Explicit



'--------------------------------------------------------
'		���[�����e�ǂݍ���
'--------------------------------------------------------
    Dim FS
    Dim rFile     ' �t�@�C���ǂݍ��ݗp
    Dim mailBody, mailSubject, mailTo, mailAttachment
    
    Set FS = WScript.CreateObject("Scripting.FileSystemObject")
    ' ������ǂݍ���
    Set rfile = FS.OpenTextFile("����.txt")  '�t�@�C�����J��
    mailSubject = rfile.ReadLine
    rFile.Close
    ' �����ǂݍ���
    Set rfile = FS.OpenTextFile("����.txt")  '�t�@�C�����J��
    mailTo = rfile.ReadLine
    rFile.Close
    
    ' �{����ǂݍ���
    Set rFile = FS.OpenTextFile("�{��.txt")  '�t�@�C�����J��
    Do Until rFile.AtEndOfStream
    	mailBody = mailBody & rFile.ReadLine & vbCrLf
    Loop

'--------------------------------------------------------
'		���[�����M�T�C�g���瑗�M
'--------------------------------------------------------
    Dim objIE
    Dim objLink

    Set objIE = CreateObject("InternetExplorer.Application")
    objIE.Visible = False

    'IE���J��
    objIE.navigate "http://enginesd.php.xdomain.jp/confirm.html"
    
    '�y�[�W���ǂݍ��܂��܂ő҂�
    Do While objIE.Busy = True Or objIE.readyState <> 4
        WScript.Sleep 100        
    Loop


    objIE.document.getElementsByName("to")(0).Value = mailTo
    objIE.document.getElementsByName("title")(0).Value = mailSubject
    objIE.document.getElementsByName("content")(0).Value = mailBody


    '���M
    objIE.document.forms(0).submit()


    '�y�[�W���ǂݍ��܂��܂ő҂�
    Do While objIE.Busy = True Or objIE.readyState <> 4
        WScript.Sleep 100        
    Loop


    objIE.Quit
    Set objIE = Nothing
