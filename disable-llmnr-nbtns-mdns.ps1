
# Deshabilitar LLMNR mediante el editor de registro de Windows:
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -Value 0 -PropertyType DWORD -Force


# -------------------------------
# Deshabilitar NetBIOS (NBT-NS)
# -------------------------------
Write-Output "Deshabilitando NetBIOS en todos los adaptadores de red..."
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled = 'TRUE'" | ForEach-Object {
    $_.SetTcpipNetbios(2) | Out-Null
    Write-Output "NetBIOS deshabilitado en adaptador: $($_.Description)"
}

# -------------------------------
# Bloquear mDNS con reglas de firewall (UDP 5353)
# -------------------------------
Write-Output "Bloqueando mDNS (UDP 5353) en el firewall..."

# Bloqueo de salida
if (-not (Get-NetFirewallRule -DisplayName "Bloquear mDNS Salida" -ErrorAction SilentlyContinue)) {
    New-NetFirewallRule -DisplayName "Bloquear mDNS Salida" `
        -Direction Outbound -Protocol UDP -LocalPort 5353 `
        -Action Block -Profile Any
    Write-Output "Regla de firewall creada: Bloquear mDNS Salida"
} else {
    Write-Output "Regla ya existe: Bloquear mDNS Salida"
}

# Bloqueo de entrada
if (-not (Get-NetFirewallRule -DisplayName "Bloquear mDNS Entrada" -ErrorAction SilentlyContinue)) {
    New-NetFirewallRule -DisplayName "Bloquear mDNS Entrada" `
        -Direction Inbound -Protocol UDP -LocalPort 5353 `
        -Action Block -Profile Any
    Write-Output "Regla de firewall creada: Bloquear mDNS Entrada"
} else {
    Write-Output "Regla ya existe: Bloquear mDNS Entrada"
}

# -------------------------------
Write-Output "LLMNR deshabilitado, NetBIOS deshabilitado y mDNS bloqueado con firewall."

