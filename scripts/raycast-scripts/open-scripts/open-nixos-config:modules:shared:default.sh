#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title shared default.nix (overlay config) (emacsclient)
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/nix.png
# @raycast.packageName nixos-config
# @raycast.description open ~/nixos-config/modules/shared/default.nix via emacsclient

FILE="$HOME/nixos-config/modules/shared/default.nix"

/Users/alexeykotomin/.local/share/bin/emacsclient -n "$FILE"
