# 🛡️ Windows Hardening

Este repositorio contiene scripts y métodos de **bastionado (hardening)** para sistemas operativos **Windows**, enfocados en reducir la superficie de ataque y proteger contra vectores comunes de movimiento lateral y captura de credenciales.

## Objetivo

Este repositorio va orientado a aumentar la seguridad de equipos Windows, deshabilitando opciones inseguras por defecto y evitando ataques comunes. 

## Medidas principales de seguridad

La mayoría de ataques a equipos Windows consisten en la obtención de credenciales o explotación de vulnerabilidades. Se recomienda cumplir con las siguientes pautas para tener el sistema seguro:

- Tener una correcta política de contraseñas, siguiendo por ejemplo las recomendaciones de [INCIBE](https://www.incibe.es/ciudadania/tematicas/contrasenas-seguras).
- Utilizar los Scripts del repositorio para deshabilitar opciones inseguras.
- No instalar archivos de origenes dudosos y si es posible tener antivirus de pago como ESET, Kaspersky o Bitdefender (Tener Windows Defender y no tener nada es lo mismo)
- Actualizar el sistema operativo

## 📜 Scripts Powershell

### `disable-llmnr-nbtns-mdns.ps1`

Este Script deshabilita los protocolos inseguros de resolución de nombres de host LLMNR, Netbios y mDNS, de manera que impide la captura de credenciales o Hashes netNTLMv2 mediante la herramienta "Responder.py". Tras aplicar esta medida de seguridad, los hosts no podran ser resueltos por nombre, sino solo por su IP.

### `LocalAccountTokenFilterPolicyDisabled.ps1`

Este Script evita la ejecución remota de comandos mediante la herramienta Psexec, creando en el registro de Windows la propiedad LocalAccountTokenFilterPolicy con valor a 0. Esta propiedad suele estar habilitada por defecto en sistemas Windows 10 y 11 **que estén actualizados**, pero en el resto de sistemas operativos Windows podría ser posible incluso acceder de manera remota como Administrador sin saber las credenciales.

### `SWEET32_mitigation.ps1`

Este Script deshabilita los cifrados inseguros basados en bloques de 64 bits usados en TLS que vienen por defecto en el servicio RDP de Windows, evitando asi el ataque conocido como SWEET32.

### `SMBServiceDisabled.ps1`

Este Script crea una regla de Firewall que impide el acceso al servicio SMB, solo para los casos en los que dicho servicio no sea necesario

## Uso

1. Habilita la ejecución de Scripts de Powershell poniendo en Powershell: Set-ExecutionPolicy Unrestricted
  
2. Clona este repositorio o descarga el archivo `.ps1`.

```bash
git clone https://github.com/DanielDamota04/Bastionado_Windows.git
```

3. Deshabilita la ejecución de Scripts poniendo: Set-ExecutionPolicy Restricted

