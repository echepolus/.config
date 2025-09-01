#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title shared files.nix (emacsclient)
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/nix.png
# @raycast.packageName nixos-config
# @raycast.description open ~/.config/nix/modules/shared/files.nix via emacsclient

FILE="$CONFIG_DIR/nix/modules/shared/files.nix"

/Users/alexeykotomin/.local/share/bin/emacsclient -n "$FILE"
