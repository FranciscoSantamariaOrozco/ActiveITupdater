@REM @echo off
powershell -ExecutionPolicy Bypass -Command "Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""\\192.168.30.82\TEMP\autoupdate.ps1""' -Verb RunAs"