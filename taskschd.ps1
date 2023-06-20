$Trigger= New-ScheduledTaskTrigger -AtStartup
# $User= "NT AUTHORITYSYSTEM"
$Action= New-ScheduledTaskAction -Execute "cmd.exe" -Argument "C:\work\start.bat"
Register-ScheduledTask -TaskName "StartupScript1" -Trigger $Trigger -Action $Action -RunLevel Highest