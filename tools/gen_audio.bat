@echo off
rem Edge の日本語音声(ja-JP-KeitaNeural)でナレーションMP3と字幕を生成する。
rem 使い方: このファイルをダブルクリック(要 Python 3 とインターネット接続)
chcp 65001 > nul
cd /d "%~dp0.."

echo edge-tts を準備しています...
python -m pip install --quiet --upgrade edge-tts
if errorlevel 1 goto err

echo ナレーションを生成しています（数分かかります）...
python tools\gen_audio.py
if errorlevel 1 goto err

echo.
echo 完了しました。assets\audio に scene-01.mp3 〜 scene-12.mp3 と captions.js を生成しました。
echo そのまま Git にコミット・プッシュすると、公開サイトが音声付きになります。
pause
exit /b 0

:err
echo.
echo エラーが発生しました。Python 3 が入っているか、インターネットに接続できるかをご確認ください。
pause
exit /b 1
