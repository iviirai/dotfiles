#!/bin/bash

###
#  This script is for deploying my dotfiles.
#  contact: ini.universe # gmail.com
#				2016
###

###
#  Overall, \033 or \e means ESC in terminal.
#  ESC[p;p;p...m each p is a property.
#  0: black 1: red     2: green  3: yellow
#  4: blue  5: purple  6: cyan   7: white
#  plus 30 gets forground color, plus 40 gets background
#+ color. \033[0m stops special color output.
###

###
#  Setup git
###

if [[ -z $1 ]]; then
	echo "first parameter should be dotfiles directory"
	exit 1;
fi

DIR=${1/%\//''}
echo $DIR

if [[ $(which git) == "" ]]; then
	echo -e "\033[35m########### install git ###########\033[0m"
	su - root -c "apt-get install git"
fi

#  git config --system read/write /etc/gitconfig for all users.
#  git config --global read/write ~/.gitconfig for current user.
#  git config read/write .git/config in current working directory,
#+ it's for current project.

#  setup user information for everytime commitment
git config --global user.name "A1phaZer0"
git config --global user.email ini.universe@gmail.com

#  setup default text editor
git config --global core.editor vim

#  setup difference analysis tool
git config --global merge.tool vimdiff

#  settings for BIG repository
git config --global core.packedGitLimit 512m
git config --global core.packedGitWindowSize 512m
git config --global pack.deltaCacheSize 2047m
git config --global pack.packSizeLimit 2047m
git config --global pack.windowMemory 2047m

#  print configured variables
echo -e "\033[35m########### git configurations ###########\033[0m"
git config --list

#  install rxvt-unicode
if [[ $(which urxvt) == "" ]]; then
	echo -e "\033[35m########### install urxvt 256color###########\033[0m"
	su - root -c "apt-get install rxvt-unicode-256color"
fi


#  setup fonts
if [[ -n $1 ]]; then
	echo -e "\033[35m########### setup fonts ###########\033[0m"
	if [[ ! -d "$HOME/.fonts" ]]; then
		mkdir $HOME/.fonts
	fi
	cp "$DIR"/fonts/gohu* $HOME/.fonts/
	OLD=`pwd`
	cd $HOME/.fonts
	mkfontdir
	mkfontscale
	fc-cache - fv
	xset +fp $HOME/.fonts
	cd $OLD
fi

#  handle xresources for urxvt
if [[ ! -e "$HOME/.Xresources" ]]; then
	echo -e "\033[35m########### Xresources ###########\033[0m"
	cp "$DIR"/Xresources $HOME/.Xresources
	xrdb -merge $HOME/.Xresources
fi

###
#  setup bash
###

echo -e "\033[35m########### setup bash ###########\033[0m"
cp "$DIR"/bash/bashrc $HOME/.bashrc
[ -d "$HOME/.config/git-prompt" ] || mkdir "$HOME/.config/git-prompt"
wget -P "$HOME/.config/git-prompt" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
wget -P "$HOME/.config/git-prompt" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh


###
#  setup vim
###

echo -e "\033[35m########### setup vim ###########\033[0m"
[ -d $HOME/.vim/bundle/Vundle.vim ] || git clone https://github.com/VundleVim/Vundle.vim.git "$HOME"/.vim/bundle/Vundle.vim
cp "$DIR"/vimrc "$HOME"/.vimrc


