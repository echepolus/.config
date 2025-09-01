#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title emacs-config emacs-app.nix
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Users/alexeykotomin/.local/share/img/icons/emacs.icns
# @raycast.packageName nixos-config
# @raycast.description open ~/.config/nix/modules/shared/config/emacs/emacs-app.nix via emacsclient

FILE="$CONFIG_DIR/nix/modules/shared/config/emacs/emacs-app.nix"

/Users/alexeykotomin/.local/share/bin/emacsclient -n "$FILE"
