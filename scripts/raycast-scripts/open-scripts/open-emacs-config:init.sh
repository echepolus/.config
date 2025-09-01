#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title emacs config init.el 
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/emacs.png
# @raycast.packageName nixos-config
# @raycast.description open ~/.config/nix/modules/shared/config/emacs/init.el via emacsclient

FILE="$CONFIG_DIR/nix/modules/shared/config/emacs/init.el"

/Users/alexeykotomin/.local/share/bin/emacsclient -n "$FILE"
