pushd "%~dp0"
mkdir C:\work
copy /Y ".\start.bat" "C:\work"
copy /Y ".\autoupdate.ps1" "C:\work"
C:\work\start.bat