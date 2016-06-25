#!/bin/bash

########################################################
#
# panel for herbstluftwm
#
########################################################

# disable path name expansion,
#+if you want it back,simply try set +f

set -f

# icons 

icon_mpc="  "
icon_vol="  "
icon_date="  "
icon_title="  "
icon_lt="" # left triangle
icon_ra="" # right arrow
icon_la="" # left arrow

# $0 is each input line. $@ means input file.

function uniq_linebuffered() {
	awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
}

# 1 means $1, and 0 is default value if there is no $1.

monitor=${1:-0}

# give monitor a gap, so we can put bar there

herbstclient pad $monitor 14

# gathering the different kinds of information and piping
#+them to the bar

{
	# music playing information from music player daemon(client)
	
	mpc idleloop player | cat &

	# volume
	# the "vol_flag" here is flag so next code block will capture
	#+and know what event it is
	
	while : ; do
		echo "vol_flag $(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')%"
		sleep 1 || break
	done > >(uniq_linebuffered) &  # process substitution
	vol_pid=$!  # the pid of last background process

	# date

	while : ; do
		date +'date_flag %H:%M'
		sleep 1 || break
	done > >(uniq_linebuffered) &
	date_pid=$!

	# waiting for events
	
	herbstclient --idle	

	# exiting

	kill $vol_pid $date_pid
} 2> /dev/null | {
	# getting a tab separated list of all tags for the specified MONITOR
	
	TAGS=( $(herbstclient tag_status $monitor) )
	unset TAGS[${#TAGS[@]}]
	time=""
	song="HAHA"
	windowtitle="BRAVO!"
	visible=true
	curtag="FF823232" # background color of current tag
	acttag="FF917154" # background color of active tag
	nemptag="FF663366" # background color of not empty tag
	ugtag="FFFF0000" # background color of urgent tag
	deftag="FFCC6600" # background color of default tag
	titlecolor="FF000000" # main color of title bar


	# handling status of tags,each one is a tag name with one char prefix

	while : ; do
		icon_tgl="" # icon of triangle
		fgcolor="" #forground color used for triangle
		echo -n "%{l}"  # for constructing bar
		for i in "${TAGS[@]}" ; do  
			case ${i:0:1} in  # cut prefix from tag status
				'#') # current tag
					echo -n "%{B#$curtag}%{F#$fgcolor}$icon_tgl"
					echo -n "%{B#$curtag}%{F-}"
					echo -n " ${i:1} "
					fgcolor=$curtag
					;; # break
				'+') # active on other monitor
					echo -n "%{B#$acttag}%{F#$fgcolor}$icon_tgl"
					echo -n "%{B#$acttag}%{F-}"
					echo -n " ${i:1} "
					fgcolor=$acttag
					;;
				':') # tag is not empty
					echo -n "%{B#$nemptag}%{F#$fgcolor}$icon_tgl"
					echo -n "%{B#$nemptag}%{F-}"
					echo -n " ${i:1} "
					fgcolor=$nemptag
					;;
				'!') # urgent tag
					echo -n "%{B#$ugtag}%{F#$fgcolor}$icon_tgl"
					echo -n "%{B#$ugtag}%{F-}"
					echo -n " ${i:1} "
					fgcolor=$ugtag
					;;
				*) # default
					echo -n "%{B#$deftag}%{F#$fgcolor}$icon_tgl"
					echo -n "%{B#$deftag}%{F#FF000000}"
					echo -n " ${i:1} "
					fgcolor=$deftag
					;;
			esac
			#echo -n " ${i:1} " # tag name
			icon_tgl="" # the left most tag doesn't have left triangle
		done
		echo -n "%{B-}%{F#$fgcolor}$icon_tgl"

		# put title in the center

		if [ ! -z $windowtitle ]; then

			echo -n "%{c}%{B-}%{F#FF9999BB}$icon_lt%{B#FF9999BB}%{F#FF333333}$icon_title%{B#FF9999BB}%{F#FF333333}${windowtitle//^/^^} %{B-}%{F#FF9999BB}$icon_tgl%{B-}%{F-}"
		else
			echo -n "%{c}%{B-}%{F#FF9999BB}$icon_lt%{B#FF9999BB}%{F#FF333333}$icon_title%{B-}%{F#FF9999BB}$icon_tgl%{B-}%{F-}"
		fi

		# align right
		echo -n "%{r}"
		echo -n "%{B-}%{F#FFCC6600}$icon_lt%{B#FFCC6600}%{F#FF000000}$icon_mpc%{B#FFCC6600}%{F#FF000000}$icon_la"
		echo -n " $song "
		echo -n "%{B#FFCC6600}%{F#FF823232}$icon_lt%{B#FF823232}%{F-}$icon_vol%{B#FF823232}%{F-}$icon_la"
		echo -n " $volume "
		echo -n "%{B#FF823232}%{F#FF999922}$icon_lt%{B#FF999922}%{F#FF000000}$icon_date%{B#FF999922}%{F#FF000000}$icon_la"
		echo -n " $date "
		echo -n "%{B-}%{F-}"
		echo ""

		# wait for next event
		#+the event is simple text from last code block

		read line || break
		cmd=( ${line} )

		# handle events

		case "${cmd[0]}" in
			tag*)
				TAGS=( $(herbstclient tag_status $monitor) )
				unset TAGS[${#TAGS[@]}]
				;;
			mpd_player|player)
				song="$(mpc current)"
				;;
			vol_flag)
				volume="${cmd[@]:1}"
				;;
			date_flag)
				date="${cmd[@]:1}"
				;;
			focus_changed|window_title_changed)
				windowtitle="${cmd[@]:2}"
				;;
			quit_panel)
				exit
				;;
			reload)
				exit
				;;
		esac
	done
} 2> /dev/null | lemonbar -d -p -g x14 -B '#FF9999BB' -F '#FFA8A8A8' -f '-gohu-gohufont-medium-r-*-*-14-*-*-*-*-*-*-*' 
