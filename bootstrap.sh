#!/bin/bash
# inspired by everyone else who's ever done such a thing, but mostly Paul Vilchez
# who turned me on to this whole dotfiles thing, unbeknownst to him

set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUNDLE_DIR="${BASE_DIR}/.vim/bundle"
BACKUP_DIR="${BASE_DIR}/.vim/backup"
MY_NAME="$(whoami)"

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
[ -d $BACKUP_DIR ] || mkdir -p $BACKUP_DIR
[ -d $BUNDLE_DIR ] || mkdir -p $BUNDLE_DIR

ln -Fs ${BASE_DIR}/vimrc ~/.vimrc #this is hella basic, but should suffice for now
# I don't want to symlink this dir, I want to create and do the installation of stuff on this machine, not carry around the config... right?
#ln -Fs ${BASE_DIR}/vim/ ~/.vim #need to make sure I have this set up properly. will have to try in a VM

#now time to install the submodules on to the new host
pushd ${BASE_DIR}
echo "$(pwd)"
popd

#git
#ln -s ${BASE_DIR}/gitconfig ~/.gitconfig #guess this means I'm adding my gitconfig next

#terminal prefs (what's the difference between input and bash_profile prefs?)
if [ -f ~/.inputrc ]
then
  mv ~/.inputrc ~/.inputrc-old
fi
ln -Fs ${BASE_DIR}/inputrc ~/.inputrc

PLATFORM="$(uname -s)"

# determine the platform you're using, which will determine whether we use
# homebrew or apt-get (in a far off universe where I may possibly choose a Ubuntu machine again)
case $PLATFORM in
  "Darwin")
    echo "You're running OS X. This is good."
    echo "Soon this will install homebrew for you"
    ;;
  "Linux")
    echo "…good for you I guess?"
    ;;
esac

#if homebrew installed properly, time to grab packages
# tmux
# screen
# tree
# rvm?
# more


#sublime text prefs
