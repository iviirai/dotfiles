#!/bin/bash

#  named pipe
npipe="/tmp/wm.fifo"

#  make tmp named pipe
[ -p "$npipe" ] || mkfifo -m 600 "$npipe"

exec ~/.config/monsterwm/panel.sh < "$npipe" &

#  start window manager
#+ redirect it's stdout

monsterwm > "$npipe"
