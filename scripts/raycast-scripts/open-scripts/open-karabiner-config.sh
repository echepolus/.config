#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title karabiner.nix (emacsclient)
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/karabiner.png
# @raycast.packageName nixos-config
# @raycast.description open ~/.config/nix/modules/shared/config/karabiner.nix via emacsclient

FILE="$CONFIG_DIR/nix/modules/shared/config/karabiner.nix"

/Users/alexeykotomin/.local/share/bin/emacsclient -n "$FILE"
