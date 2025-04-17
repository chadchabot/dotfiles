#!/bin/bash
source ./lib.sh

bot "Setting up your dotfiles for you, you handsome bastard."

declare -r BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
declare -r BUNDLE_DIR="${BASE_DIR}/vim/bundle"
BACKUP_DIR="${BASE_DIR}/vim/backup"
AUTOLOAD_DIR="${BASE_DIR}/vim/autoload"

#MY_NAME="$(whoami)"

bot "Starting with Vim bits"
action "cleaning up vim directives"
#vim dir setup
if [ -L ~/.vim ]; then #is ~/.vim a symlink
  rm ~/.vim
elif [ -d ~/.vim ]; then #is ~/.vim a directory
  mv ~/.vim ~/.vim-old
fi

ln -Fs "${BASE_DIR}/vimrc" ~/.vimrc #this is hella basic, but should suffice for now
# I don't want to symlink this dir, I want to create and do the installation of stuff on this machine, not carry around the config... right?
ln -Fs "${BASE_DIR}/vim/" ~/.vim
#don't forget about neovim!
ln -Fs "${BASE_DIR}/vimrc" ~/.nvimrc
ln -Fs "${BASE_DIR}/vim/" ~/.nvim

action "Setting up vim directories"
#does the DIR exist? if not, create it
[ -d "$BACKUP_DIR" ]   || mkdir -p "$BACKUP_DIR"
[ -d "$BUNDLE_DIR" ]   || mkdir -p "$BUNDLE_DIR"
[ -d "$AUTOLOAD_DIR" ] || mkdir -p "$AUTOLOAD_DIR"

if [ -f ~/.vim/autoload/pathogen.vim ]; then
  ok "Pathogen already installed"
else
  action "Downloading pathogen..."
  PATHOGEN_DEST="${AUTOLOAD_DIR}/pathogen.vim"
  #TODO: I should totally be checking for completion of this
  curl -LSso "$PATHOGEN_DEST" https://tpo.pe/pathogen.vim
  ok "Pathogen download complete"
fi

#TODO: break this out into its own file
#install vim bundles
action "Installing NERDTree"
declare -a nerd_tree=("NERDTree file navigation" "https://github.com/scrooloose/nerdtree.git")
get_vim_bundle "$BUNDLE_DIR" "${nerd_tree[0]}" "${nerd_tree[1]}"
warn "Don't forget to run :Helptags when you first run vim!"

#action "Installing Fugitive"
#declare -a fugitive=("Fugitive Git plugin" "git://github.com/tpope/vim-fugitive.git")
#get_vim_bundle "$BUNDLE_DIR" "${fugitive[0]}" "${fugitive[1]}"

action "Installing Solarized theme"
declare -a solarized_theme=("Solarized theme" "https://github.com/altercation/vim-colors-solarized.git")
get_vim_bundle "$BUNDLE_DIR" "${solarized_theme[0]}" "${solarized_theme[1]}"

action "Installing syntax packages"
declare -a coffeescript_syntax=("Vim Coffeescript syntax package" "https://github.com/kchmck/vim-coffee-script.git")
get_vim_bundle "$BUNDLE_DIR" "${coffeescript_syntax[0]}" "${coffeescript_syntax[1]}"

declare -a arduino_syntax=("Arduino syntax package" "https://github.com/sudar/vim-arduino-syntax.git")
get_vim_bundle "$BUNDLE_DIR" "${arduino_syntax[0]}" "${arduino_syntax[1]}"

declare -a less_syntax=("Less syntax package" "https://github.com/groenewege/vim-less.git")
get_vim_bundle "$BUNDLE_DIR" "${less_syntax[0]}" "${less_syntax[1]}"

action "Installing vim-airline status bar tool"
declare -a airline_tool=("Vim Airline status bar tool" "https://github.com/bling/vim-airline.git")
get_vim_bundle "$BUNDLE_DIR" "${airline_tool[0]}" "${airline_tool[1]}"

action "Installing vim indent guide tool"
declare -a indent_guide=("Vim Indent Guides" "https://github.com/nathanaelkane/vim-indent-guides.git")
get_vim_bundle "$BUNDLE_DIR" "${indent_guide[0]}" "${indent_guide[1]}"

action "Installing Auto-pairs tool"
declare -a auto_pairs=("Auto-pairs" "https://github.com/jiangmiao/auto-pairs.git")
get_vim_bundle "$BUNDLE_DIR" "${auto_pairs[0]}" "${auto_pairs[1]}"

action "Installing Endwise"
declare -a endwise=("Endwise" "https://github.com/tpope/vim-endwise.git")
get_vim_bundle "$BUNDLE_DIR" "${endwise[0]}" "${endwise[1]}"

#Future consideration
#https://github.com/ctrlpvim/ctrlp.vim
#https://github.com/tpope/vim-rails
#https://github.com/bronson/vim-trailing-whitespace
