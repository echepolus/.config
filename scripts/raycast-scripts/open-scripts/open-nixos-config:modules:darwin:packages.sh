#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title darwin packages.nix (emacsclient)
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/nix.png
# @raycast.packageName nixos-config
# @raycast.description open ~/.config/nix/modules/darwin/packages.nix via emacsclient

FILE="/Users/alexeykotomin/.config/nix/modules/darwin/packages.nix"

/Users/alexeykotomin/.config/scripts/raycast-scripts/open-scripts/emacsclient -n "$FILE"
