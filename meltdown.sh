#!/usr/bin/env bash
#
# meltdown.sh - Botón de pánico para liberar recursos y reiniciar la interfaz gráfica en situaciones críticas.
#
# MIT License
#
# Copyright (c) 2025
#

###############################################################################
# CONFIGURACIÓN
###############################################################################

# Patrones de procesos a matar (en orden prioritario).
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

# Limpiar contenedores Docker (true/false).
ENABLE_DOCKER_CLEANUP=true

# Auto-detección del administrador de archivos (o specify: "nautilus", "dolphin", etc.).
FILE_MANAGER="auto"

# Reiniciar swap (muy agresivo) (true/false).
RESTART_SWAP=false

# Reiniciar la interfaz gráfica (true/false).
RESTART_UI=true

###############################################################################
# FUNCIONES
###############################################################################

sync_buffers() {
  sudo sync
}

drop_caches() {
  echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
}

close_all_windows() {
  if command -v wmctrl >/dev/null 2>&1; then
    for win in $(wmctrl -l | awk '{print $1}'); do
      wmctrl -ic "$win" 2>/dev/null
    done
  fi
}

kill_heavy_processes() {
  for pattern in "${PROCESS_PATTERNS[@]}"; do
    sudo pkill -9 -f "$pattern" 2>/dev/null
  done
}

cleanup_docker() {
  if [ "$ENABLE_DOCKER_CLEANUP" = true ] && command -v docker >/dev/null 2>&1; then
    local containers
    containers=$(sudo docker ps -q 2>/dev/null)
    if [ -n "$containers" ]; then
      sudo docker kill $containers &>/dev/null
    fi
  fi
}

restart_swap() {
  if [ "$RESTART_SWAP" = true ]; then
    sudo swapoff -a && sudo swapon -a
  fi
}

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
    echo "nautilus"
  fi
}

restart_file_manager() {
  local fm
  fm=$(get_file_manager)
  $fm -q 2>/dev/null
  nohup $fm &>/dev/null &
}

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
# ORQUESTACIÓN
###############################################################################

meltdown() {
  close_all_windows
  kill_heavy_processes
  sync_buffers
  drop_caches
  cleanup_docker
  restart_swap
  restart_file_manager
  if [ "$RESTART_UI" = true ]; then
    restart_window_manager
  fi
}

###############################################################################
# EJECUCIÓN
###############################################################################
{
  meltdown
} &>/dev/null &
