# user, host, full path, and time/date
# on two lines for easier vgrepping


######################### different length ##########################

function precmd {

# The width of terminal.
(( TERMWIDTH = ${COLUMNS} - 1 ))

# length of graphics
SYM_LEN=8

# length of information
INFO_LEN=${#${(%):-%n@%m}}

# size of PWD
PWD_SIZE=${#${(%):-%~}}

# length of PWD for finally showing on bar && truncate the path if nessary
PWD_LEN=""
PWD=${(%):-%~}

if [[ "$SYM_LEN + $INFO_LEN + $PWD_SIZE" -gt $TERMWIDTH ]]; then
	(( PWD_LEN = $TERMWIDTH - $SYM_LEN - $INFO_LEN ))
	PWD="$PWD_LEN<...<%~%<<"
else 
	PWD_LEN=$PWD_SIZE
fi

######################### line symbols ##############################

# line symbols for constructing prompt
# ls1="─"; ls2="┌"; ls3="└"; ls4="┤"; ls5="├"; ls6=">" ls7="┐" ls8="┘"


######################### line filled ###############################

# ┌─┤ ├..... ┤ ├─┐ length of graphic is 8
# initialize line
line=""

# left padding: l:expr::string1::string2:
line="\${(l:(($TERMWIDTH - $PWD_LEN - $SYM_LEN - $INFO_LEN))::$ls1:)}"

}
# Prompt

PROMPT=$'%{\e[0;34m%}%B[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;34m%}@%{\e[0m%}%{\e[0;36m%}%m%{\e[0;34m%}%B:%b%{\e[1;37m%}$PWD%{\e[0;34m%}%B]%b
%{\e[0;34m%}%B%%%{\e[0m%}%b '

####################### right prompt ###############################

PS2=$' \e[0;34m%}%B$ls6%{\e[0m%}%b '
