#!/bin/bash
# inspired by everyone else who's ever done such a thing, but mostly Paul Vilchez
# who turned me on to this whole dotfiles thing, unbeknownst to him

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#todo
# - ensure that pathogen and any other dependencies are installed
# - add bash_profile/bashrc
# - add gitconfig
# - optionally download dev stuff like homebrew, tmux, screen, etc..
#   - this one is a bit more complicated, but not unrealistic
#     may have to do some system detection stuff to make use homebrew or apt-get
#     depending on the system software, though it's unlikely I'll move away from
#     a mac in the near term, though using VMs is a big part of my work, so worth
#     considering

#vim
# need to make sure the backup directory exists
mkdir -p $HOME/.vim/backup
ln -Fs ${BASEDIR}/vimrc ~/.vimrc #this is hella basic, but should suffice for now
#ln -s ${BASEDIR}/vim/ ~/.vim #need to make sure I have this set up properly. will have to try in a VM

#git
#ln -s ${BASEDIR}/gitconfig ~/.gitconfig #guess this means I'm adding my gitconfig next

#terminal
if [ -f ~/.inputrc ]
then
  mv ~/.inputrc ~/.inputrc-old
fi
ln -Fs ${BASEDIR}/inputrc ~/.inputrc

#sublime text prefs

#install homebrew
if [ "$(uname -s)" == "Darwin" ]
then
  # do stuff that i'm not sure about just yet
  echo "this thing is running, right?"
fi

#if homebrew installed properly, time to grab packages
# tmux
# screen
# tree
# rvm?
# more
