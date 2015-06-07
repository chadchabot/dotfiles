#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#todo
# - backup existing .vimrc and the rest of the install
# - ensure that pathogen and any other dependencies are installed
# - add bash_profile/bashrc
# - add gitconfig
# - optionally download dev stuff like homebrew, tmux, screen, etc..
#   - this one is a bit more complicated, but not unrealistic
#     may have to do some system detection stuff to make use homebrew or apt-get
#     depending on the system software, though it's unlikely I'll move away from
#     a mac in the near term, though using VMs is a big part of my work, so worth
#     considering
# - what about terminal prefs? autocomplete case insenstive and such. where does that live? ~/.inputrc?

#vim
# need to make sure the backup directory exists
mkdir $HOME/.vim/backup
ln -s ${BASEDIR}/vimrc ~/.vimrc #this is hella basic, but should suffice for now
#ln -s ${BASEDIR}/vim/ ~/.vim #need to make sure I have this set up properly. will have to try in a VM

#git
#ln -s ${BASEDIR}/gitconfig ~/.gitconfig #guess this means I'm adding my gitconfig next
