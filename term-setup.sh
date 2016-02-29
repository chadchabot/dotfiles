#!/bin/bash
source ./lib.sh

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bot "Setting up Git preferences"
move_and_symlink ~/.gitconfig ${BASE_DIR}/gitconfig
if [ -f ~/.gitconfig ]; then
  mv ~/.gitconfig ~/.gitconfig-old
fi
ln -s ${BASE_DIR}/gitconfig ~/.gitconfig
ln -Fs ${BASE_DIR}/gitmessage ~/.gitmessage
ln -Fs ${BASE_DIR}/gitignore ~/.gitignore
ok "Finished setting up git prefs"

#terminal prefs (what's the difference between input and bash_profile prefs?)
bot "Setting up terminal prefs"
move_and_symlink ~/.inputrc ${BASE_DIR}/inputrc
move_and_symlink ~/.bashrc ${BASE_DIR}/bashrc

bot "Setting up terminal extras"
move_and_symlink ~/.functions ${BASE_DIR}/functions.sh
move_and_symlink ~/.aliases ${BASE_DIR}/aliases.sh

ok "Finished with terminal prefs"
