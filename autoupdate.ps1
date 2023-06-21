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
    # # Creacion bucle (no funciona en el Pre-Enviroment)
    # $Trigger= New-ScheduledTaskTrigger -AtLogon
    # $Action= New-ScheduledTaskAction -Execute "C:\work\start.bat"
    # Register-ScheduledTask -TaskName "StartupScript1" -Trigger $Trigger -Action $Action -RunLevel Highest

    # Atualizar
    Get-WindowsUpdate -AcceptAll -Install -Verbose -AutoReboot
    $updates | ForEach-Object {
        $_ | Install-WindowsUpdate -AcceptAll -Install -Verbose ;
 
        # Obter lista dos drivers nao-instalados
    $devices = Get-PnpDevice | Where-Object { $_.NoDriver }
    $outputFile = "\\nas002\TEMP\Drivers.txt"
    foreach ($device in $devices) {
        $hardwareIds = $device.HardwareID -join ", "
        $deviceName = $device.FriendlyName
    
        # Escribir el nombre del dispositivo y su ID de hardware en el archivo
        "$deviceName`n$hardwareIds`n" | Out-File -Append -FilePath $outputFile
        Write-Host "Os drivers que nao se posso instalar fican nun arquivo no C:\work\Drivers.txt"
    }

    Remove-Item -Path "C:\work" -Recurse -Force
    shutdown.exe /r /f /t 0
    }

} else {
    # Nao hay atualizaciones disponibles

    # Obter lista dos drivers nao-instalados
    $devices = Get-PnpDevice | Where-Object { $_.NoDriver }
    $outputFile = "C:\work\Drivers.txt"
    foreach ($device in $devices) {
        $hardwareIds = $device.HardwareID -join ", "
        $deviceName = $device.FriendlyName
    
        # Escribir el nombre del dispositivo y su ID de hardware en el archivo
        "$deviceName`n$hardwareIds`n" | Out-File -Append -FilePath $outputFile
        Write-Host "Os drivers que nao se posso instalar fican nun arquivo no C:\work\Drivers.txt"
    }

    Write-Host "Nao hai mais atualizaçoes. Presione cualquier tecla para continuar...";
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown");
}

shutdown.exe /r /f /t 0