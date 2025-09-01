#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title darwin home-manager.nix (emacsclient)
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/nix.png
# @raycast.packageName nixos-config
# @raycast.description open ~/.config/nix/modules/darwin/home-manager.nix via emacsclient

FILE="$CONFIG_DIR/nix/modules/darwin/home-manager.nix"

/Users/alexeykotomin/.local/share/bin/emacsclient -n "$FILE"
