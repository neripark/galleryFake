@echo off

rem ローカルのプロジェクトディレクトリまでのフルパス 
rem 例 set PJ_PATH=C:\Users\username\Documents\project\
set PJ_PATH=
rem その他変数宣言
set CURRENT_DIR=%~dp0
set TGT_DIR=copied
set TGT_PATH=%CURRENT_DIR%%TGT_DIR%\
set LIST_FILE_NAME=list.txt
set LOGFILE=log.txt
set /a CNT_INPUT=0
set /a CNT_OK=0
set /a CNT_NG=0

echo ********* 処理開始 %DATE% %TIME% ********* >>%LOGFILE%
if EXIST %PJ_PATH% (
  rem 処理続行
) else (
  echo %PJ_PATH% が存在しません。処理を終了します。
  echo %PJ_PATH% が存在しません。処理を終了します。>>%LOGFILE%
  pause
  goto dirNotExists
)

echo ------ 前回結果削除 開始 ------>>%LOGFILE%
rem ファイルをすべて削除
del /S /Q %TGT_PATH%
rem 削除対象フォルダの中のフォルダ構造をすべて削除
for /D %%1 in (%TGT_PATH%) do rmdir /S /Q "%%1"
echo ------ 前回結果削除 完了 ------>>%LOGFILE%

echo ------ コピー処理 開始 ------>>%LOGFILE%
rem リストファイルの中身を１行ずつ読み取ってコピー
for /f "delims=" %%a in (%LIST_FILE_NAME%) do (
    call :sub %%a
)
echo ------ コピー処理 完了 ------>>%LOGFILE%
echo 入力件数：%CNT_INPUT%>>%LOGFILE%
echo OK件数：%CNT_OK%>>%LOGFILE%
echo NG件数：%CNT_NG%>>%LOGFILE%
:dirNotExists
echo ********* 処理終了 %DATE% %TIME% ********* >>%LOGFILE%
echo.>>%LOGFILE%
exit

:sub
rem /を\に変換してコピーを実施
set /a CNT_INPUT=%CNT_INPUT%+1
set str=%~1
set str_rep=%str:/=\%
echo F | xcopy %PJ_PATH%%str_rep% %TGT_PATH%%str_rep% /Y
if %ERRORLEVEL% == 0 (
    set /a CNT_OK=%CNT_OK%+1
) else (
    set /a CNT_NG=%CNT_NG%+1
    echo %~1 のコピーに失敗しました。>>%LOGFILE%
)
exit /b