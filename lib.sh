#!/bin/bash

# some bits borrowed from https://github.com/atomantic/dotfiles/

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

function ok() {
  echo -e "$COL_GREEN[ok]$COL_RESET "$1
}

function bot() {
  echo -e "\n$COL_GREEN\[._.]/$COL_RESET - "$1
}

function running() {
  echo -en "$COL_YELLOW ⇒ $COL_RESET"$1": "
}

function action() {
  echo -e "\n$COL_YELLOW[action]:$COL_RESET\n ⇒ $1..."
}

function warn() {
  echo -e "$COL_YELLOW[warning]$COL_RESET "$1
}

function error() {
  echo -e "$COL_RED[error]$COL_RESET "$1
}

function get_confirmation() {
  #have something here to allow for a yes/no dialog
  echo ''
}

# expects 3 arguements
#  $1 - function being called
#  $2 - success message
#  $3 - error message
function is_success() {
  if [[ $1 -eq 0 ]]; then
    ok "$2"
  else
    warn "$3"
  fi
}

# expects 4 args
#  $1 path to bundle dir
#  $2 bundle repo name
#  $3 bundle repo url
function get_vim_bundle() {
  #pull out bundle name from bundle repo url
  FILE_NAME=${3##*/}
  BUNDLE_NAME=`echo "$FILE_NAME" | cut -f 1 -d '.'`
  if [ -d ${1}/${BUNDLE_NAME} ]; then
    ok "${BUNDLE_NAME} already installed"
  else
    running "${2} not installed. Installing now"
    pushd $1
    git clone ${3}
    SUCCESS=$?
    is_success $SUCCESS "installed ${BUNDLE_NAME}" "error downloading ${BUNDLE_NAME}"
    popd
  fi
}

function install_homebrew() {
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function install_brews() {
  #if homebrew installed properly, time to grab packages
  declare -a brew_packages=("caskroom/cask/brew-cask" "the_silver_searcher" "tree" "httpie")
  for package in "${brew_packages[@]}"
  do
    install_brew_package $package
  done
}

function install_casks() {
  #install things like VLC, google chrome, firefox, iterm2
  declare -a cask_packages=("vlc" "google-chrome" "firefox" "iterm2" "carbon-copy-cloner")
}

function install_brew_package() {
  if brew list -l | grep -q ${1}; then
    ok "${1} already installed"
  else
    brew install "${1}"
  fi
}
