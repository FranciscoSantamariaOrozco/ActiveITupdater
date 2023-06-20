# Obtener la lista de dispositivos sin controladores instalados
$devices = Get-PnpDevice | Where-Object { $_.NoDriver }

# Crear un archivo de texto para almacenar la lista
$outputFile = "C:\ruta\al\archivo.txt"

# Recorrer la lista de dispositivos y escribir sus ID de hardware en el archivo
foreach ($device in $devices) {
    $hardwareIds = $device.HardwareID -join ", "
    $deviceName = $device.FriendlyName

    # Escribir el nombre del dispositivo y su ID de hardware en el archivo
    "$deviceName`n$hardwareIds`n" | Out-File -Append -FilePath $outputFile
}

# Mostrar un mensaje de confirmación
"Lista de dispositivos sin controladores instalados guardada en: $outputFile"
