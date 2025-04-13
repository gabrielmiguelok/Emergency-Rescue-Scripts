# Emergency-Rescue-Scripts

Scripts simples y efectivos para liberar recursos rápidamente en situaciones críticas, disponibles para **Linux** y **Windows**, bajo licencia **MIT**.

## Índice

- [Introducción](#introducción)
- [Script para Linux](#script-para-linux)
  - [Configuración y uso](#configuración-y-uso-linux)
  - [Crear un atajo de teclado](#crear-un-atajo-de-teclado-en-linux)
- [Script para Windows](#script-para-windows)
  - [Configuración y uso](#configuración-y-uso-windows)
  - [Crear un acceso directo con atajo de teclado](#crear-un-acceso-directo-con-atajo-de-teclado-en-windows)
- [Licencia](#licencia)

## Introducción

Este repositorio proporciona scripts rápidos para emergencias cuando el sistema está saturado. Cierran forzosamente procesos críticos como navegadores, IDEs, herramientas de comunicación, y opcionalmente reinician interfaces gráficas o el explorador de archivos.

## Script para Linux

### meltdown.sh

Este script fuerza el cierre de procesos pesados, limpia cachés del sistema, reinicia interfaces gráficas y libera memoria.

### Configuración y uso (Linux)

1. **Clonar o descargar el script:**

```bash
git clone <url-del-repo>
cd Emergency-Rescue-Scripts/linux
chmod +x meltdown.sh
```

2. **Opcional:** Configura `sudo` sin contraseña para evitar prompts durante la emergencia.

- Ejecuta:

```bash
sudo visudo
```
- Agrega al final:

```
tu_usuario ALL=(ALL) NOPASSWD: /usr/bin/sync, /usr/bin/tee, /usr/bin/pkill, /usr/bin/docker, /usr/bin/swapoff, /usr/bin/swapon
```

### Crear un atajo de teclado en Linux

- **GNOME:**
  - Ve a **Configuración > Atajos de teclado**.
  - Añadir nuevo atajo:
    - Nombre: `Meltdown`
    - Comando: `/ruta/completa/meltdown.sh`
    - Asignar tecla: Ej. `Alt+F4`

- **KDE:**
  - Preferencias del Sistema → Atajos → Atajos personalizados → Añadir nuevo → Comando:
    - Nombre: `Meltdown`
    - Comando: `/ruta/completa/meltdown.sh`
    - Asignar tecla: Ej. `Alt+F4`

Ahora, al presionar `Alt+F4` (u otra tecla asignada), se ejecutará inmediatamente el script para liberar recursos.

---

## Script para Windows

### meltdown.bat

Este script fuerza el cierre inmediato de procesos pesados en Windows como Chrome, Node, Slack, Teams, Zoom, etc. Opcionalmente reinicia `explorer.exe`.

### Configuración y uso (Windows)

1. **Ubicación del script:**
- Crea una carpeta fácil, ej. `C:\Scripts`.
- Guarda allí `meltdown.bat`.

```batch
@echo off
taskkill /IM chrome.exe /F
taskkill /IM node.exe /F
taskkill /IM slack.exe /F
taskkill /IM discord.exe /F
taskkill /IM teams.exe /F
taskkill /IM zoom.exe /F
taskkill /IM firefox.exe /F
taskkill /IM brave.exe /F
taskkill /IM code.exe /F

:: Opcional (reiniciar interfaz)
:: taskkill /IM explorer.exe /F
:: start explorer.exe
exit
```

2. **Ejecutar siempre como administrador (recomendado):**
- Clic derecho sobre `meltdown.bat` → Propiedades → Acceso directo → Opciones avanzadas → "Ejecutar como administrador".

### Crear un acceso directo con atajo de teclado en Windows

- **Acceso directo:**
  - Clic derecho sobre `meltdown.bat` → Enviar a → Escritorio (crear acceso directo).

- **Atajo rápido:**
  - En el Escritorio, clic derecho al acceso directo → Propiedades.
  - En pestaña "Acceso directo", asigna combinación de teclas ej. `Ctrl + Alt + M`.

Ahora, al presionar la combinación asignada, se ejecutará inmediatamente.

---

## Licencia

Este proyecto se distribuye bajo licencia **MIT**. Eres libre de usar, modificar, distribuir y compartir según las condiciones de esta licencia.

