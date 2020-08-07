
Set objWShell = CreateObject("Wscript.Shell") 
bat = "cmd /c " & objWShell.CurrentDirectory & "\02_main.bat"
objWShell.run bat, vbHide

