# 🛡️ Windows Hardening

Este repositorio contiene scripts y métodos de **bastionado (hardening)** para sistemas operativos **Windows**, enfocados en reducir la superficie de ataque y proteger contra vectores comunes de movimiento lateral y captura de credenciales.

## 🎯 Objetivo

Desactivar y bloquear protocolos de resolución de nombres **inseguros o innecesarios** como:

- **LLMNR** (Link-Local Multicast Name Resolution)
- **NBT-NS** (NetBIOS Name Service)
- **mDNS** (Multicast DNS)

Estos protocolos pueden ser utilizados por atacantes con herramientas como `Responder` para capturar hashes NTLM o suplantar servicios en red.

## 📜 Scripts incluidos

### `disable-llmnr-nbtns-mdns.ps1`

Script de PowerShell que:

- 🛑 **Desactiva LLMNR** mediante el Registro de Windows.
- 🔻 **Desactiva NetBIOS** (NBT-NS) en todos los adaptadores de red activos.
- 🔥 **Bloquea mDNS** (UDP puerto 5353) tanto de entrada como de salida, mediante reglas de firewall.

### Requisitos

- Windows 10 / 11 / Server (2016 en adelante)
- Ejecución con **privilegios de administrador**

## 🚀 Uso

1. Clona este repositorio o descarga el archivo `.ps1`.

```bash
git clone https://github.com/DanielDamota04/Bastionado_Windows.git
