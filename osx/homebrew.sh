#!/bin/bash

function install_homebrew() {
  #Of course I trust executable code from a random url that I have no control over...
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

#Standard brews are CLI utility programs
function install_brews() {
  declare -a brew_packages=("the_silver_searcher" "tree" "httpie" "ffmpeg" "binutils" "valgrind" "libdvdcss" "postgresql" "rbenv" "rbenv-vars" "node" "mtr" "shellcheck" "imagemagick" "graphviz")
  #screen, tmux
  for package in "${brew_packages[@]}"
  do
    install_brew_package $package || continue
  done
}

#Casks are typically GUI applications that are installed as a nicety when setting up a new machine
function install_casks() {
  declare -a dev_essentials=("sublime-text" "google-chrome" "firefox" "iterm2" "spectacle" "spotify" "caffeine" "slack" "sequel-pro" "dropbox" "sqlitebrowser" "macvim" "appcleaner" "quicklook-json")
  declare -a personal=("polymail" "superduper" "vlc" "carbon-copy-cloner" "flux" "little-snitch" "xscope" "transmit" "evernote" "skype" "handbrake" "macdown" "steam" "1password", "vanilla")

  # cool! You can iterate through elements in multiple arrays using this notation!
  for package in "${dev_essentials[@]}" "${personal[@]}"
  do
    install_brew_cask "${package}" || continue
  done

  #someday move to a more easily maintained list of applications in an external source file
  #while IFS= read -r package
  #do
  #  echo "${package}"
  #done < dev_apps.txt
}

function install_brew_cask() {
  CASK_NAME=`echo "${1}"`

  if cask_is_installed ${CASK_NAME}; then
    ok "${CASK_NAME} is already installed"
  else
    echo "trying to install ${CASK_NAME}"
    brew cask install --appdir=/Applications $CASK_NAME
  fi
}

function install_fonts() {
  brew tap homebrew/cask-fonts
  brew install font-incosolata
  brew install font-inter
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
