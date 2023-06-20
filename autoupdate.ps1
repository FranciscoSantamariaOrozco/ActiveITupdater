# Script Autoupdate para novos computadores
############################################################################
Write-Host "Script Autoupdate"

# Configuracion Energia
############################################################################
powercfg.exe /change standby-timeout-ac 0 ;
powercfg.exe /change hibernate-timeout-ac 0 ;

# Modulos y dependencias WinUpdate
############################################################################
Install-PackageProvider -Name NuGet -Force
Install-Module -Name PSWindowsUpdate -Force -Verbose
Import-Module PSWindowsUpdate -Verbose;

# Microsoft Update
# Comprobar atualizaciones disponibles
############################################################################
$updates = Get-WindowsUpdate -IsInstalled:$false

if ($updates.Count -gt 0) {
    # Criar bucle
    # Caminho absoluto do script

    # $rutascript = "\\192.168.30.82\TEMP\autoupdate.ps1"
    # Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "updatescript" -Value "powershell.exe -ExecutionPolicy Bypass -File $rutascript"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "updatescript" -Value "powershell.exe -ExecutionPolicy Bypass -File '.\autoupdate.ps1'"

    # Atualizar
    Get-WindowsUpdate -AcceptAll -Install -Verbose -AutoReboot
    $updates | ForEach-Object {
        $_ | Install-WindowsUpdate -AcceptAll -Install -Verbose ;
    shutdown.exe /r /f /t 0
    }

} else {
    # Nao hay atualizaciones disponibles
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "updatescript"
    # Eliminar o lanzador do atualizador
    Write-Host "Nao hai mais atualizaçoes" ;
    shutdown.exe /r /f /t 0
}

shutdown.exe /r /f /t 0