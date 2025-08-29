#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title karabiner.nix (emacsclient)
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/karabiner.png
# @raycast.packageName nixos-config
# @raycast.description open ~/nixos-config/modules/shared/config/karabiner.nix via emacsclient

FILE="$HOME/nixos-config/modules/shared/config/karabiner.nix"

/Users/alexeykotomin/.local/share/bin/emacsclient -n "$FILE"
