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
## bitmap font goes to ~/.fonts, ttf goes to .local/share/fonts
#  fc-cache -fv
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
	fc-cache -fv
	xset +fp $HOME/.fonts
	cd $OLD
	mkdir -p  $HOME/.local/share/fonts
	cp "$DIR"/fonts/Monofur* $HOME/.local/share/fonts
	cp "$DIR"/fonts/fontawesome-webfont.ttf $HOME/.local/share/fonts
	fc-cache -fv
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
if [ ! -d "$HOME/.config/git-prompt" ]; then
	mkdir "$HOME/.config/git-prompt"
	wget -P "$HOME/.config/git-prompt" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	wget -P "$HOME/.config/git-prompt" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
fi


###
#  setup vim
###

echo -e "\033[35m########### setup vim ###########\033[0m"
[ -d $HOME/.vim/bundle/Vundle.vim ] || git clone https://github.com/VundleVim/Vundle.vim.git "$HOME"/.vim/bundle/Vundle.vim
cp "$DIR"/vim/vimrc "$HOME"/.vimrc

###
#  setup llvm for You Complete Me
#  checkout llvm.org/apt
###

# su - root -c "add-apt-repository 'deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.8 main'" wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -
# su - root -c "apt-get update"
# su - root -c "apt-get install clang-3.8 clang-3.8-doc libclang-common-3.8-dev libclang-3.8-dev libclang1-3.8 libclang1-3.8-dbg libllvm-3.8-ocaml-dev libllvm3.8 libllvm3.8-dbg lldb-3.8 llvm-3.8 llvm-3.8-dev llvm-3.8-doc llvm-3.8-examples llvm-3.8-runtime clang-format-3.8 python-clang-3.8 lldb-3.8-dev liblldb-3.8-dbg"
su - root -c "apt-get install build-essential cmake"
su - root -c "apt-get install python-dev python3-dev"
su - root -c "ldconfig"

cp "$DIR"/vim/ycm_extra_conf_c.py "$HOME"/.ycm_extra_conf_c.py
cp "$DIR"/vim/ycm_extra_conf_cc.py "$HOME"/.ycm_extra_conf_cc.py

###
#  setup monsterwm
###

# prepare libs
su - root -c "apt-get install libxinerama-dev"
su - root -c "apt-get install libx11-dev"

# map superkey
cp "$DIR"/superkey_map "$HOME"/.config/superkey_map

# lemonbar helper scripts
if [[ ! -d "$HOME"/.config/monsterwm ]]; then
	mkdir "$HOME"/.config/monsterwm
	cp "$DIR"/monsterwm/wm.sh "$HOME"/.config/monsterwm
	chmod +x "$HOME"/.config/monsterwm/wm.sh
	cp "$DIR"/monsterwm/panel.sh "$HOME"/.config/monsterwm
	chmod +x "$HOME"/.config/monsterwm/panel.sh
fi


###
#  setup compton
###
cp "$DIR"/compton.conf "$HOME"/.config/compton.conf


###
#  setup ss
###
if [[ $(which pip) == "" ]]; then
	su - root -c "apt-get install python-pip"
	su - root -c "pip install shadowsocks"
	if [[ -L "/usr/local/bin/sslocal" ]]; then
		su - root -c "ln -s $HOME/.local/bin/sslocal /usr/local/bin/sslocal"
	fi
fi

if [[ -e "$HOME"/.shadowsocks.json ]]; then
	cp "$DIR"/shadowsocks.json "$HOME"/.shadowsocks.json


###
#  setup lightdm
###
	su - root -c "cp "$DIR"/lightdm/monsterwm.desktop /usr/share/xgreeters/"
	su - root -c "cp "$DIR"/lightdm/50-monsterwm.conf /etc/lightdm/lightdm.conf.d/"
