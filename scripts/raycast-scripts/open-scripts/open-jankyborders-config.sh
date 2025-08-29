#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title jankyborders.nix 
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/nix.png
# @raycast.packageName nixos-config
# @raycast.description open ~/nixos-config/modules/shared/config/jankybordersrc

FILE="$HOME/nixos-config/modules/shared/config/jankybordersrc"

/Users/alexeykotomin/.local/share/bin/emacsclient -n "$FILE"
