#!/bin/bash

function install_homebrew() {
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function install_brews() {
  declare -a brew_packages=("caskroom/cask/brew-cask" "the_silver_searcher" "tree" "httpie")
  #screen, tmux
  for package in "${brew_packages[@]}"
  do
    install_brew_package $package
  done
}

function install_casks() {
  declare -a cask_packages=("vlc" "sublime-text" "google-chrome" "firefox" "iterm2" "carbon-copy-cloner" "spectacle" "spotify" "caffeine" "flux" "little-snitch" "xscope" "transmit" "slack" "evernote" "skype" "handbrake" "sequel-pro")
  for package in "${cask_packages[@]}"
  do
    install_brew_cask "${package}"
  done
}

function install_brew_cask() {
  CASK_NAME=`echo "${1}"`

  if cask_is_installed ${CASK_NAME}; then
    ok "${CASK_NAME} is already installed"
  else
    brew cask install "${CASK_NAME}"
  fi
}

function cask_is_installed() {
  #TODO: look in both the installed brew casks as well as in
  #      the /Applications folder
  #      $ system_profiler SPApplicationsDataType | ag sequel
  #      ^^ works, but will not find the exact match because of the hyphen in the cask name.
  if brew cask list | grep -q ${1}; then
    return 0
  else
    return 1
  fi
}

function install_brew_package() {
  #TODO: this is hacky. find a better way
  BREW_NAME=`echo "${1}" | cut -f 3 -d '/'`
  if brew list -l | grep -q ${BREW_NAME}; then
    ok "${BREW_NAME} already installed"
  else
    brew install "${1}"
  fi
}
