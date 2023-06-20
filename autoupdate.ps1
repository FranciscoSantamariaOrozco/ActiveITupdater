# Script Autoupdate para novos computadores
############################################################################
Write-Host "Script Autoupdate"

# Configuracion Energia
############################################################################
powercfg.exe /change standby-timeout-ac 0 ;
powercfg.exe /change hibernate-timeout-ac 0 ;

# Modulos y dependencias WinUpdate
############################################################################
Install-PackageProvider -Name NuGet -Force -verbose
Install-Module -Name PSWindowsUpdate -Force -Verbose
Import-Module PSWindowsUpdate
Import-Module ScheduledTasks

# Microsoft Update
# Comprobar atualizaciones disponibles
############################################################################
$updates = Get-WindowsUpdate -IsInstalled:$false

if ($updates.Count -gt 0) {
    # Criar bucle
    #$rutaScript = "C:\work\start.bat"

    $trigger = New-ScheduledTaskTrigger -AtStartup
    # $User= "NT AUTHORITYSYSTEM" -User $User
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -NonInteractive -ExecutionPolicy Unrestricted -Command "C:\work\autoupdate.ps1""
    # $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -Settings $settings
    Register-ScheduledTask -TaskName "autoupdater" -Trigger $trigger -Action $action -RunLevel Highest -Force

    # Atualizar
    Get-WindowsUpdate -AcceptAll -Install -Verbose -AutoReboot
    $updates | ForEach-Object {
        $_ | Install-WindowsUpdate -AcceptAll -Install -Verbose ;
    shutdown.exe /r /f /t 0
    }

} else {
    # Nao hay atualizaciones disponibles
    # Eliminar o lanzador do atualizador
    
    Write-Host "Nao hai mais atualizaçoes. Presione cualquier tecla para continuar..."
    # Esperar a que el usuario presione una tecla
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    Unregister-ScheduledTask -TaskName "autoupdater" -Confirm:$false

    shutdown.exe /r /f /t 0
}

shutdown.exe /r /f /t 0