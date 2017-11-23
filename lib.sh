#!/bin/bash
source bash_term_colours.sh
# some bits borrowed from https://github.com/atomantic/dotfiles/

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

function is_osx(){
  PLATFORM="$(uname -s)"
  if [ "$PLATFORM" = "Darwin" ]; then
    return 0
  else
    return 1
  fi
}

function get_confirmation() {
  #have something here to allow for a yes/no dialog
  #TODO: finish this tonight
  read -p $1 -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo "yes"
    return 0
  else
    echo "no"
    return 1
  fi
}

# expects 2 arguments
#  $1 - file (with path) you're "archiving" and overwriting
#  $2 - file (with path) that is the source of the symlink
function move_and_symlink() {
  if [ -f ${1} ]; then
    mv ${1} ${1}-old
  fi
  #TODO: allow for option between -Fs and -s so gitconfig file will work
  ln -Fs ${2} ${1}
}

# expects 3 arguements
#  $1 - function being called
#  $2 - success message
#  $3 - error message
function is_success() {
  if [[ $1 -eq 0 ]]; then #TODO: why is this wrapped twice?
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

