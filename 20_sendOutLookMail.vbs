Option Explicit

'--------------------------------------------------------
'		VBS����Outlook�N��
'--------------------------------------------------------
    Dim oApp        'As Outlook.Application Outlook��Application �I�u�W�F�N�g������
    Dim myNameSpace 'As Outlook.NameSpace ���O�̃X�y�[�X�ƌ����Ă��A�A
    Dim myFolder    'As Outlook.Folder �t�H���_�[�w��

    Set oApp = CreateObject("Outlook.Application")	'outlook �N����CreateObject�� �����ꂾ�ƕ����N�����Ă��܂��������ق�
    Set myNameSpace = oApp.GetNamespace("MAPI")		'�����P ���O��� �� �w�� �ƌ����Ă��A.GetNamespace("MAPI")��������
    
    '���͍�ƃt�H���_�[�̎w��(.GetDefaultFolder) �� �\��(.Display)
    Set myFolder = myNameSpace.GetDefaultFolder(6) '�K��̃t�H���_�[ olFolderInbox=6 �w��
    myFolder.Display  '�\�� �����̃N�Z�� .Visible = True �Ƃ�肪��������

    '�ʏ�T�C�Y olNormalWindow=2 �ŕ\��(�ق��� olMaximized=0,olMinimized=1)
    oApp.ActiveWindow.WindowState = 2   'olNormalWindow=2 �� �Z�b�g


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
'		���[�����M
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
'		�I������
'--------------------------------------------------------
Set item = Nothing
Set olk = Nothing
WScript.Quit 0

'�I���m�F vbYesNo=4 �� �͂��Ƃ������𕷂��A
If MsgBox("�A�E�g���b�N���I�����܂����H", 4) = 6 Then   ' vbYes=6[�͂�]�����������
	oApp.Quit    '�A�E�g���b�N���I������
End If

