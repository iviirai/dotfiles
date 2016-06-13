xset +fp /home/lorentz/.fonts

# eval `cat ~/.fehbg`
feh --bg-fill '/home/lorentz/Pictures/1.jpg' --bg-fill ~/Pictures/2.png
xset fp rehash
xrdb -merge ~/.Xresources # update x resources db
xset fp rehash
xmodmap ~/.config/superkey_map
compton &>/dev/null &
unclutter -grab -noevents -root &
exec ~/.config/monsterwm/wm.sh 
