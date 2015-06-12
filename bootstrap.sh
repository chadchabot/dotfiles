#!/bin/bash
# inspired by everyone else who's ever done such a thing, but mostly Paul Vilchez
# who turned me on to this whole dotfiles thing, unbeknownst to him

set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUNDLE_DIR="${BASE_DIR}/vim/bundle"
BACKUP_DIR="${BASE_DIR}/vim/backup"
AUTOLOAD_DIR="${BASE_DIR}/vim/autoload"

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

#vim dir setup
if [ -f ~/.vim ]; then
  mv ~/.vim ~/.vim-old
fi
echo "Setting up directories"
[ -d $BACKUP_DIR ] || mkdir -p $BACKUP_DIR
[ -d $BUNDLE_DIR ] || mkdir -p $BUNDLE_DIR
[ -d $AUTOLOAD_DIR ] || mkdir -p $AUTOLOAD_DIR

ln -Fs ${BASE_DIR}/vimrc ~/.vimrc #this is hella basic, but should suffice for now
# I don't want to symlink this dir, I want to create and do the installation of stuff on this machine, not carry around the config... right?
# clear out /.vim/folder
ln -Fs ${BASE_DIR}/vim/ ~/.vim

#install pathogen
echo "Downloading pathogen..."
PATHOGEN_DEST="${AUTOLOAD_DIR}/pathogen.vim"
curl -LSso $PATHOGEN_DEST https://tpo.pe/pathogen.vim #I should totally be checking for completion of this
echo "Pathogen download complete"

#now time to install any other fancy submodules, like nerdtree
pushd ${BASE_DIR}
echo "$(pwd)"
popd

#git
#ln -s ${BASE_DIR}/gitconfig ~/.gitconfig #guess this means I'm adding my gitconfig next

#terminal prefs (what's the difference between input and bash_profile prefs?)
if [ -f ~/.inputrc ]; then
  mv ~/.inputrc ~/.inputrc-old
fi
ln -Fs ${BASE_DIR}/inputrc ~/.inputrc


# determine the platform you're using, which will determine whether we use
# homebrew or apt-get (in a far off universe where I may possibly choose a Ubuntu machine again)

PLATFORM="$(uname -s)"
case "$(uname -s)" in
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
