#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title aerospace config 
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/nix.png
# @raycast.packageName nixos-config
# @raycast.description open ~/nixos-config/modules/shared/config/aerospace.toml via emacsclient

FILE="$HOME/nixos-config/modules/shared/config/aerospace.toml"

/users/alexeykotomin/.local/share/bin/emacsclient -n "$FILE"
