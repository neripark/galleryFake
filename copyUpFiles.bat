@echo off

rem ���[�J���̃v���W�F�N�g�f�B���N�g���܂ł̃t���p�X 
rem �� set PJ_PATH=C:\Users\username\Documents\project\
set PJ_PATH=
rem ���̑��ϐ��錾
set CURRENT_DIR=%~dp0
set TGT_DIR=copied
set TGT_PATH=%CURRENT_DIR%%TGT_DIR%\
set LIST_FILE_NAME=list.txt
set LOGFILE=log.txt
set /a CNT_INPUT=0
set /a CNT_OK=0
set /a CNT_NG=0

echo ********* �����J�n %DATE% %TIME% ********* >>%LOGFILE%
if EXIST %PJ_PATH% (
  rem �������s
) else (
  echo %PJ_PATH% �����݂��܂���B�������I�����܂��B
  echo %PJ_PATH% �����݂��܂���B�������I�����܂��B>>%LOGFILE%
  pause
  goto dirNotExists
)

echo ------ �O�񌋉ʍ폜 �J�n ------>>%LOGFILE%
rem �t�@�C�������ׂč폜
del /S /Q %TGT_PATH%
rem �폜�Ώۃt�H���_�̒��̃t�H���_�\�������ׂč폜
for /D %%1 in (%TGT_PATH%) do rmdir /S /Q "%%1"
echo ------ �O�񌋉ʍ폜 ���� ------>>%LOGFILE%

echo ------ �R�s�[���� �J�n ------>>%LOGFILE%
rem ���X�g�t�@�C���̒��g���P�s���ǂݎ���ăR�s�[
for /f "delims=" %%a in (%LIST_FILE_NAME%) do (
    call :sub %%a
)
echo ------ �R�s�[���� ���� ------>>%LOGFILE%
echo ���͌����F%CNT_INPUT%>>%LOGFILE%
echo OK�����F%CNT_OK%>>%LOGFILE%
echo NG�����F%CNT_NG%>>%LOGFILE%
:dirNotExists
echo ********* �����I�� %DATE% %TIME% ********* >>%LOGFILE%
echo.>>%LOGFILE%
exit

:sub
rem /��\�ɕϊ����ăR�s�[�����{
set /a CNT_INPUT=%CNT_INPUT%+1
set str=%~1
set str_rep=%str:/=\%
echo F | xcopy %PJ_PATH%%str_rep% %TGT_PATH%%str_rep% /Y
if %ERRORLEVEL% == 0 (
    set /a CNT_OK=%CNT_OK%+1
) else (
    set /a CNT_NG=%CNT_NG%+1
    echo %~1 �̃R�s�[�Ɏ��s���܂����B>>%LOGFILE%
)
exit /b