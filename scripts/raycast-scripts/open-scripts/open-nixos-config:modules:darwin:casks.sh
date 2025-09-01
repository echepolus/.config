#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title casks.nix
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/nix.png
# @raycast.packageName nixos-config
# @raycast.description open ~/.config/nix/modules/darwin/casks.nix via emacsclient

FILE="$CONFIG_DIR/nix/modules/darwin/casks.nix"

/Users/alexeykotomin/.local/share/bin/emacsclient -n "$FILE"
