Write-Host "=== Deshabilitando cifrado 3DES en Windows ===" -ForegroundColor Cyan

# Comprobar si se ejecuta como administrador
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "Este script debe ejecutarse como Administrador."
    exit
}

# Ruta del registro para el cifrado 3DES
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168"

# Crear la clave si no existe
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    Write-Host "Creada clave de registro: $regPath"
}

# Deshabilitar 3DES
New-ItemProperty -Path $regPath -Name "Enabled" -Value 0 -PropertyType "DWORD" -Force | Out-Null
New-ItemProperty -Path $regPath -Name "DisabledByDefault" -Value 1 -PropertyType "DWORD" -Force | Out-Null

Write-Host "`n✅ 3DES deshabilitado correctamente." -ForegroundColor Green
Write-Host "ℹ️ Reinicia el sistema para aplicar los cambios." -ForegroundColor Yellow