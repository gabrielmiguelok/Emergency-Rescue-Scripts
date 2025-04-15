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

---

## Script para Linux

### meltdown.sh

Este script ejecuta una secuencia de cierre inmediata de procesos pesados como navegadores (Chrome, Firefox, Brave), herramientas de desarrollo (Node, VSCode) y comunicación (Slack, Discord, Teams, Zoom). Posteriormente, limpia cachés del sistema, reinicia el administrador de archivos y opcionalmente la interfaz gráfica.

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
tu_usuario ALL=(ALL) NOPASSWD: /usr/bin/sync, /usr/bin/tee, /usr/bin/pkill
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

Ahora, al presionar la tecla asignada, se ejecutará inmediatamente el script.

---

## Script para Windows

### meltdown.bat

Este script fuerza el cierre inmediato de procesos pesados en Windows como Chrome, Node, Slack, Teams, Zoom, Firefox, Brave, y VSCode. Opcionalmente permite reiniciar `explorer.exe`.

### Configuración y uso (Windows)

1. **Ubicación del script:**
- Crea una carpeta, por ejemplo `C:\Scripts`.
- Guarda allí `meltdown.bat`.

```batch
@echo off
set PROCESOS=chrome.exe node.exe slack.exe discord.exe teams.exe zoom.exe firefox.exe brave.exe code.exe

for %%P in (%PROCESOS%) do (
    taskkill /IM %%P /F 2>nul
)

:: Opcional (reiniciar interfaz gráfica)
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

