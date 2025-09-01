#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title ghostty config 
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/nix.png
# @raycast.packageName nixos-config
# @raycast.description open ~/.config/nix/modules/shared/config/ghostty/config via emacsclient

FILE="$CONFIG_DIR/nix/modules/shared/config/ghostty/config"

/Users/alexeykotomin/.local/share/bin/emacsclient -n "$FILE"
