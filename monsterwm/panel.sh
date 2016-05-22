#!/bin/bash

#enum { RESIZE, MOVE };
#enum { TILE, MONOCLE, BSTACK, GRID, FIBONACCI, DUALSTACK, EQUAL, MODES };


 #*   the desktop number/id
 #*   the desktop's client count
 #*   the desktop's tiling layout mode/id
 #*   whether the desktop is the current focused (1) or not (0)
 #*   whether any client in that desktop has received an urgent hint
 #*   and the current window's title
 
#id
#count
#layout
#focused
#urgent
#title
icon_mpc="  "
icon_vol="  "
icon_date="  "
icon_title="  "
icon_lt="" # left triangle
icon_ra="" # right arrow
icon_la="" # left arrow





curtag="FF823232" # background color of current tag
acttag="FF917154" # background color of active tag
nemptag="FF663366" # background color of not empty tag
ugtag="FFFF0000" # background color of urgent tag
deftag="FFCC6600" # background color of default tag
titlecolor="FF000000" # main color of title bar

names=( "term" "web" "img" "misc" "alpha" )

function lineout()
{
	awk -W interactive '$0 != l { print; l=$0; fflush(); }' "$@"
}



{
        while :; do
 		echo "volume_ $(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*\)%\].*/\1/')"
 		sleep 1 || break
 	done > >(lineout) &


	while :; do
		date +'date_ %H:%M'
		sleep 1 || break
	done > >(lineout) &


	while :; do
		read  -r info
		if [[ -n "$info" && "$info" != "$prev" && "$info" =~ ^([0-9]+:){4} ]]; then
			prev="$info"
		fi
		read -ra desktops <<< "$prev"
		for i in {0..4}; do
			id=${desktops[$i]:0:1}
			count=${desktops[$i]:2:1}
			layout=${desktops[$i]:4:1}
			focused=${desktops[$i]:6:1}
			urgent=${desktops[$i]:8:1}
			if [ "$focused" -ne 0 ]; then
				fg[$i]="%{F-}"
				bg[$i]="%{B-}"
				ul[$i]="%{U#$curtag}" #underline color
				ub[$i]="%{+u}"
				ue[$i]="%{-u}"
			elif [ "$urgent" -ne 0 ]; then
				fg[$i]="%{F-}"
				bg[$i]="%{B-}"
				ul[$i]="%{U#$ugtag}"
				ub[$i]="%{+u}"
				ue[$i]="%{-u}"
			elif [ "$count" -ne 0 ]; then
				fg[$i]="%{F-}"
                                bg[$i]="%{B-}"
                                ul[$i]="%{U#$nemptag}"
                                ub[$i]="%{+u}"
                                ue[$i]="%{-u}"
			else
				fg[$i]="%{F-}"
				bg[$i]="%{B-}"
				ul[$i]="%{U-}"
				ub[$i]="%{-u}"
				ue[$i]="%{-u}"
			fi
				
		done
		echo  " ${fg[0]}${bg[0]}${ul[0]}${ub[0]} ${names[0]} ${ue[0]} ${fg[1]}${bg[1]}${ul[1]}${ub[1]} ${names[1]} ${ue[1]} ${fg[2]}${bg[2]}${ul[2]}${ub[2]} ${names[2]} ${ue[2]} ${fg[3]}${bg[3]}${ul[3]}${ub[3]} ${names[3]} ${ue[3]} ${fg[4]}${bg[4]}${ul[4]}${ub[4]} ${names[4]} ${ue[4]}"
	done

} 2> /dev/null | {
	while read line  || true; do
		cmd=( $line )
		case "${cmd[0]}" in
		"date_") 
			date=${cmd[1]}
			;;
		"volume_") 
			vol=${cmd[1]}
			;;
		*)  
			tags=$line
			;;
		esac
		if [[ -n "$tags" && -n "$vol" && -n "$date" ]]; then
			echo "%{l} $tags%{r}%{F#$curtag}%{U#$curtag}%{+u}$icon_vol%{-u}%{B-}%{F-} $vol%% %{F#$nemptag}%{U#$nemptag}%{+u}$icon_date%{-u}%{B-}%{F-} $date "
		fi
	done
} 2> /dev/null | lemonbar -d -p -g x22 -u 4 -B '#99212121' -F '#FFA8A8A8' -f '-gohu-gohufont-medium-r-*-*-14-*-*-*-*-*-*-*'
#default panel foreground color shuould be A8A8A8
