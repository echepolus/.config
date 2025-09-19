# #!/usr/bin/env bash
#
# sid="$1"
# windows=$(aerospace list-windows --workspace "$sid")
#
# if [ -z "$windows" ]; then
#   sketchybar --set $NAME drawing=off
#   exit 0
# fi
#
# sketchybar --set $NAME drawing=on
#
# if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
#   sketchybar --set $NAME background.color=0xff5ac8fa label.color=0xff000000
# else
#   sketchybar --set $NAME background.color=0x44ffffff label.color=0xffffffff
# fi


if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.color=0x88FF00FF label.shadow.drawing=on icon.shadow.drawing=on background.border_width=2
else
  sketchybar --set $NAME background.color=0x44FFFFFF label.shadow.drawing=off icon.shadow.drawing=off background.border_width=0
fi
