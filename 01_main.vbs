dim fso
set fso = createObject("Scripting.FileSystemObject")
CurrentDirectory = fso.getParentFolderName(WScript.ScriptFullName)


Set objWShell = CreateObject("Wscript.Shell") 
bat = "cmd /c " & CurrentDirectory & "\02_main.bat"
objWShell.run bat, vbHide
