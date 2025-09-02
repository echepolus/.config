#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title jankyborders.nix 
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/nix.png
# @raycast.packageName nixos-config
# @raycast.description open ~/.config/nix/modules/shared/config/jankybordersrc

FILE="/Users/alexeykotomin/.config/nix/modules/shared/config/jankybordersrc"

/Users/alexeykotomin/.config/scripts/raycast-scripts/open-scripts/emacsclient -n "$FILE"
