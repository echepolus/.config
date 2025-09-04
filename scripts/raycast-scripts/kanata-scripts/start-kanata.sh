#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title ❇️❤️ Start Kanata 
# @raycast.mode fullOutput  

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.config/kanata/icons/default.ico

# Documentation:
# @raycast.author plasmadice
# @raycast.authorURL https://github.com/plasmadice

set -euo pipefail

KANATA_PORT=10000
KANATA_CONFIG="/Users/alexeykotomin/.config/kanata/config.kbd"
KANATA_BIN="/Users/alexeykotomin/.nix-profile/bin/kanata"
LOG_FILE="/Users/alexeykotomin/.local/log/kanata-startup.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $*" | tee -a "$LOG_FILE"
}

# --------------------------
# 1. Получение sudo-пароля
# --------------------------
pw_name="supa" # имя пароля в Keychain
pw_account=$(id -un)

if ! cli_password=$(security find-generic-password -w -s "$pw_name" -a "$pw_account"); then
  echo "❌ Could not get password (error $?)"
  exit 1
fi

# --------------------------
# 2. Убиваем старые процессы
# --------------------------
if lsof -i :"$KANATA_PORT" >/dev/null 2>&1; then
    log "Port $KANATA_PORT is in use, killing existing processes"
    lsof -ti :"$KANATA_PORT" | xargs echo "$cli_password" | sudo -S kill -9 2>/dev/null || true
    sleep 2
fi

if pgrep -f "kanata.*config.kbd" >/dev/null 2>&1; then
    log "Found existing kanata processes, terminating them"
    echo "$cli_password" | sudo -S pkill -f "kanata.*config.kbd" 2>/dev/null || true
    sleep 2
fi

# --------------------------
# 3. Проверка Karabiner HID
# --------------------------
log "Checking Karabiner VirtualHIDDevice services"

if ! launchctl print system/com.example.karabiner-vhidmanager >/dev/null 2>&1; then
    log "Starting Karabiner VirtualHIDDevice Manager"
    echo "$cli_password" | sudo -S launchctl bootstrap system /Library/LaunchDaemons/com.example.karabiner-vhidmanager.plist
fi

sleep 5

if ! systemextensionsctl list | grep -q "org.pqrs.Karabiner-DriverKit-VirtualHIDDevice.*activated"; then
    log "❌ Karabiner system extension not activated"
    echo "❌ Karabiner system extension not activated"
    exit 1
fi

# --------------------------
# 4. Запуск Kanata
# --------------------------
log "Starting Kanata"
if echo "$cli_password" | sudo -S "$KANATA_BIN" -c "$KANATA_CONFIG" --port "$KANATA_PORT" >/dev/null 2>&1 & then
  echo "✅ Kanata started successfully!"
else
  echo "❌ Failed to start Kanata."
  exit 1
fi
