@echo off
rem �܂��J���җp�R�}���h�v�����v�g���N�����Ă���
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat"

rem MSBuild�Ńr���h����(C++)
cd %~dp0
MSBuild ..\01_SBL_Xaqro_Printer_odaka_hituji\project\0000\build_sim\TARGET.sln /t:build

if %ERRORLEVEL% neq 0 (
    echo ErrorLevel:%ERRORLEVEL%
    echo �r���h���s
)

rem %~dp0 �@�ˁ@%0�ɃI�v�V�����\���́w ~ �x�Ɓw d �x�Ɓw p �x���t�������̂ł��B
rem ~�@�@�@�ˁ@(�_�u���N�I�[�g)������
rem %0  ���s����Ă���t�@�C���̃p�X�ł��B "C:\���\���\" ����Ȋ����Ł@�_�u���N�I�[�g���ז��ɂȂ邽�߁A%~0 �Ƃ���


