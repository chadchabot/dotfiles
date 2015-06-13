#!/bin/bash
# inspired by everyone else who's ever done such a thing, but mostly Paul Vilchez
# who turned me on to this whole dotfiles thing, unbeknownst to him

source ./lib.sh

set -e

bot "Setting up your dotfiles for you, you handsome bastard."

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

bot "Starting with Vim bits"
action "cleaning up vim directives"
#vim dir setup
if [ -L ~/.vim ]; then
  rm ~/.vim
elif [ -d ~/.vim ]; then
  mv ~/.vim ~/.vim-old
fi

ln -Fs ${BASE_DIR}/vimrc ~/.vimrc #this is hella basic, but should suffice for now
# I don't want to symlink this dir, I want to create and do the installation of stuff on this machine, not carry around the config... right?
ln -Fs ${BASE_DIR}/vim/ ~/.vim

action "Setting up vim directories"
[ -d $BACKUP_DIR ] || mkdir -p $BACKUP_DIR
[ -d $BUNDLE_DIR ] || mkdir -p $BUNDLE_DIR
[ -d $AUTOLOAD_DIR ] || mkdir -p $AUTOLOAD_DIR

#install pathogen
action "Downloading pathogen..."
PATHOGEN_DEST="${AUTOLOAD_DIR}/pathogen.vim"
curl -LSso $PATHOGEN_DEST https://tpo.pe/pathogen.vim #I should totally be checking for completion of this
ok "Pathogen download complete"

#install nerdtree
if [ -d ${BUNDLE_DIR}/nerdtree ]; then
  ok "nerdtree already installed. rad."
else
  pushd $BUNDLE_DIR
  git clone https://github.com/scrooloose/nerdtree.git
  SUCCESS=$?
  if [[ $SUCCESS -eq 0 ]];then
    ok "added nerdtree, just fine"
  else
    warn "error downloading nerdtree"
  fi
  popd
fi
warn "Don't forget to run :Helptags when you first run vim!"

#now time to install any other fancy plugins or submodules
#pushd ${BASE_DIR}
#echo "$(pwd)"
#popd

#git
bot "Setting up Git preferences"
#ln -s ${BASE_DIR}/gitconfig ~/.gitconfig #guess this means I'm adding my gitconfig next



#terminal prefs (what's the difference between input and bash_profile prefs?)
bot "Setting up terminal prefs"
if [ -f ~/.inputrc ]; then
  mv ~/.inputrc ~/.inputrc-old
fi
ln -Fs ${BASE_DIR}/inputrc ~/.inputrc
ok "Finished with terminal prefs"

# determine the platform you're using, which will determine whether we use
# homebrew or apt-get (in a far off universe where I may possibly choose a Ubuntu machine again)
bot "Setting up Homebrew and those bits"
PLATFORM="$(uname -s)"
case "$(uname -s)" in
  "Darwin")
    echo "You're running OS X. This is good."
    echo "Soon this will install homebrew for you"
    ;;
  "Linux")
    echo "You're running linux… good for you I guess?"
    ;;
esac
ok "Finished with Homebrew"

#if homebrew installed properly, time to grab packages
# tmux
# screen
# tree
# rvm?
# more


#sublime text prefs

ok "Everything is done! Congrats"
