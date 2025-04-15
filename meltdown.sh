#!/usr/bin/env bash
#
# meltdown.sh - Botón de pánico minimalista para liberar recursos y reiniciar la interfaz gráfica en situaciones críticas.
#
# MIT License
#
# Copyright (c) 2025
#
# Permiso es concedido, de forma gratuita, a cualquier persona que obtenga una copia
# de este software y los archivos de documentación asociados (el "Software"), para
# tratar en el Software sin restricción, incluyendo sin limitación los derechos de
# usar, copiar, modificar, fusionar, publicar, distribuir, sublicenciar y/o vender copias
# del Software, y para permitir a las personas a quienes se les proporcione el Software
# que lo hagan, sujeto a las siguientes condiciones:
#
# El aviso de copyright anterior y este aviso de permiso deberán ser
# incluidos en todas las copias o partes sustanciales del Software.
#
# EL SOFTWARE SE PROPORCIONA "TAL CUAL", SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O IMPLÍCITA,
# INCLUYENDO PERO NO LIMITADO A GARANTÍAS DE COMERCIALIZACIÓN, IDONEIDAD PARA UN PROPÓSITO
# PARTICULAR Y NO INFRACCIÓN. EN NINGÚN CASO LOS AUTORES O TITULARES DEL COPYRIGHT SERÁN
# RESPONSABLES DE NINGUNA RECLAMACIÓN, DAÑO U OTRA RESPONSABILIDAD, YA SEA EN UNA ACCIÓN CONTRACTUAL,
# AGRAVIO O CUALQUIER OTRA FORMA, QUE SURJA DE O EN CONEXIÓN CON EL SOFTWARE O EL USO U OTROS TRATOS EN EL SOFTWARE.
#

###############################################################################
# CONFIGURACIÓN (Open to Extension, Closed for Modification)
###############################################################################

# Lista de patrones de procesos en orden de prioridad (los más críticos primero).
PROCESS_PATTERNS=(
  "chrome"
  "node"
  "slack"
  "discord"
  "teams"
  "zoom"
  "firefox"
  "brave"
  "code"
)

# El administrador de archivos que quieras reiniciar.
# Si se pone "auto", se intenta detectar entre los más comunes.
FILE_MANAGER="auto"

# Reiniciar la interfaz gráfica completa (gestor de ventanas/entorno de escritorio).
RESTART_UI=true

###############################################################################
# FUNCIONES (Responsabilidad Única)
###############################################################################

# 1. Matar (SIGKILL) los procesos pesados según la lista de patrones.
kill_heavy_processes() {
  for pattern in "${PROCESS_PATTERNS[@]}"; do
    sudo pkill -9 -f "$pattern" 2>/dev/null
  done
}

# 2. Cerrar todas las ventanas abiertas utilizando wmctrl, si está disponible.
close_all_windows() {
  if command -v wmctrl >/dev/null 2>&1; then
    for win in $(wmctrl -l | awk '{print $1}'); do
      wmctrl -ic "$win" 2>/dev/null
    done
  fi
}

# 3. Sincroniza buffers a disco.
sync_buffers() {
  sudo sync
}

# 4. Libera caches (pagecache, dentries, inodes).
drop_caches() {
  echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
}

# 5. Retorna el administrador de archivos (o detecta si está en "auto").
get_file_manager() {
  if [ "$FILE_MANAGER" != "auto" ] && [ -n "$FILE_MANAGER" ]; then
    echo "$FILE_MANAGER"
  else
    local candidates=("nautilus" "dolphin" "nemo" "caja" "thunar")
    for fm in "${candidates[@]}"; do
      if command -v "$fm" >/dev/null 2>&1; then
        echo "$fm"
        return
      fi
    done
    echo "nautilus"  # Fallback si no detecta ninguno.
  fi
}

# 6. Reinicia el administrador de archivos.
restart_file_manager() {
  local fm
  fm=$(get_file_manager)
  # Matar las instancias anteriores de ese file manager (sin mostrar errores).
  pkill -9 "$fm" 2>/dev/null
  # Relanza en segundo plano.
  nohup "$fm" &>/dev/null &
}

# 7. Reinicia el gestor de ventanas o entorno de escritorio (si GNOME o KDE).
restart_window_manager() {
  if pgrep -x "gnome-shell" >/dev/null 2>&1; then
    sudo pkill -HUP gnome-shell
  elif pgrep -x "plasmashell" >/dev/null 2>&1; then
    kquitapp5 plasmashell 2>/dev/null
    sleep 2
    kstart5 plasmashell 2>/dev/null
  fi
}

###############################################################################
# ORQUESTACIÓN: Secuencia de PÁNICO (Meltdown)
###############################################################################
meltdown() {
  # 1. Matar los procesos más pesados.
  kill_heavy_processes

  # 2. Cerrar ventanas (si wmctrl existe).
  close_all_windows

  # 3. Sincronizar buffers a disco.
  sync_buffers

  # 4. Liberar cache.
  drop_caches

  # 5. Reiniciar el administrador de archivos.
  restart_file_manager

  # 6. Opcionalmente, reiniciar la interfaz gráfica.
  if [ "$RESTART_UI" = true ]; then
    restart_window_manager
  fi
}

###############################################################################
# EJECUCIÓN
###############################################################################
meltdown
