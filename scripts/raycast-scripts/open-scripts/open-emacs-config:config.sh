#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title emacs-config config.org
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/emacs.png
# @raycast.packageName nixos-config
# @raycast.description open ~/.config/nix/modules/shared/config/emacs/config.org via emacsclient

FILE="/Users/alexeykotomin/.config/nix/modules/shared/config/emacs/config.org"

/Users/alexeykotomin/.config/scripts/raycast-scripts/open-scripts/emacsclient -n "$FILE"
