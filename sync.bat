@echo off
cd /d C:\Users\tobi4\noter
powershell -NoProfile -ExecutionPolicy Bypass -File vault-changed.ps1
if errorlevel 1 exit /b 0
echo ==== %date% %time% vault changed, syncing ==== >> sync-log.txt
call npx quartz sync >> sync-log.txt 2>&1
if errorlevel 1 exit /b 1
powershell -NoProfile -ExecutionPolicy Bypass -File vault-changed.ps1 -Save
