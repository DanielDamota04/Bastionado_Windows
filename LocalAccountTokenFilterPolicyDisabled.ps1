Write-Host "=== Configurando LocalAccountTokenFilterPolicy ==="

# Verifica permisos de administrador
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "Este script debe ejecutarse como Administrador."
    exit
}

# Ruta del registro
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$propertyName = "LocalAccountTokenFilterPolicy"
$propertyValue = 0

# Crear la clave si no existe
if (-not (Test-Path $regPath)) {
    Write-Host "Creando clave de registro: $regPath"
    New-Item -Path $regPath -Force | Out-Null
}

# Establecer el valor
New-ItemProperty -Path $regPath -Name $propertyName -Value $propertyValue -PropertyType "DWORD" -Force | Out-Null

Write-Host "`LocalAccountTokenFilterPolicy establecido en 0 correctamente." -ForegroundColor Green
Write-Host "Reinicia el sistema o reinicia el servicio de red para aplicar los cambios." -ForegroundColor Yellow