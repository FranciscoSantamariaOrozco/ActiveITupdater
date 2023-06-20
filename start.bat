@REM @echo off
powershell -ExecutionPolicy Bypass -Command "Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""C:\work\autoupdate.ps1""' -Verb RunAs"
@REM powershell -ExecutionPolicy Bypass -Command "Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""\\192.168.30.82\TEMP\autoupdate.ps1""' -Verb RunAs"
@REM net use Z: %~dp0 /PERSISTENT:no 