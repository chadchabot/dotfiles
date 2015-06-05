#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#vim
ln -s ${BASEDIR}/vimrc ~/.vimrc #this is hella basic, but should suffice for now
#ln -s ${BASEDIR}/vim/ ~/.vim #need to make sure I have this set up properly. will have to try in a VM

#git
#ln -s ${BASEDIR}/gitconfig ~/.gitconfig #guess this means I'm adding my gitconfig next
