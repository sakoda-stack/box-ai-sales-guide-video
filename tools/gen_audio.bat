@echo off
rem Edge の日本語音声(ja-JP-KeitaNeural)でナレーションMP3と字幕を生成する。
rem 使い方: このファイルをダブルクリック(要 Python 3 とインターネット接続)
chcp 65001 > nul
setlocal
cd /d "%~dp0.."

rem Python の呼び出し方を判定(py ランチャ → python の順)
set "PY="
py -3 --version >nul 2>&1 && set "PY=py -3"
if not defined PY (python --version >nul 2>&1 && set "PY=python")
if not defined PY goto nopython

echo 使用する Python:
%PY% --version
echo.

echo edge-tts を準備しています...
%PY% -m pip install --quiet --upgrade edge-tts
if errorlevel 1 goto err

echo ナレーションを生成しています（数分かかります）...
%PY% tools\gen_audio.py
if errorlevel 1 goto err

echo.
echo 完了しました。assets\audio に scene-01.mp3 〜 scene-12.mp3 と captions.js を生成しました。
echo そのまま Git にコミット・プッシュすると、公開サイトが音声付きになります。
pause
exit /b 0

:nopython
echo.
echo Python 3 が見つかりませんでした。
echo https://www.python.org/downloads/windows/ からインストールし
echo （インストール時に「Add python.exe to PATH」にチェック）、もう一度実行してください。
pause
exit /b 1

:err
echo.
echo エラーが発生しました。インターネットに接続できるか、社内プロキシの制限がないかをご確認ください。
echo 生成先: assets\audio
pause
exit /b 1
