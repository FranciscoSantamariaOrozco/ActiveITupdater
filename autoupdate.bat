@REM @echo off
powershell -ExecutionPolicy Bypass -Command "Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""C:\work\autoupdate.ps1""' -Verb RunAs"