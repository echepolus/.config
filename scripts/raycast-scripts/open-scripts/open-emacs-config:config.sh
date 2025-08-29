#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title emacs-config config.org
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/emacs.png
# @raycast.packageName nixos-config
# @raycast.description open ~/nixos-config/modules/shared/config/emacs/config.org via emacsclient

FILE="$HOME/nixos-config/modules/shared/config/emacs/config.org"

/Users/alexeykotomin/.local/share/bin/emacsclient -n "$FILE"
