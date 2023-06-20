@REM @echo off
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -Command "Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass -File "".\autoupdate.ps1""' -Verb RunAs"
@REM powershell -ExecutionPolicy Bypass -Command "Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""\\192.168.30.82\TEMP\autoupdate.ps1""' -Verb RunAs"