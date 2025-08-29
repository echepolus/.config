#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title shared packages.nix (emacsclient)
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/nix.png
# @raycast.packageName nixos-config
# @raycast.description open ~/nixos-config/modules/shared/packages.nix via emacsclient

FILE="$HOME/nixos-config/modules/shared/packages.nix"

/Users/alexeykotomin/.local/share/bin/emacsclient -n "$FILE"
