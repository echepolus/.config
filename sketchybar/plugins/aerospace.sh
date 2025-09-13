#!/usr/bin/env bash

sid="$1"
windows=$(aerospace list-windows --workspace "$sid")

if [ -z "$windows" ]; then
  sketchybar --set $NAME drawing=off
  exit 0
fi

sketchybar --set $NAME drawing=on

if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.color=0xff5ac8fa label.color=0xff000000
else
  sketchybar --set $NAME background.color=0x44ffffff label.color=0xffffffff
fi
