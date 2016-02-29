#!/bin/bash
# inspired by everyone else who's ever done such a thing, but mostly Paul Vilchez
# who turned me on to this whole dotfiles thing, unbeknownst to him

source ./lib.sh
source ./osx/homebrew.sh

set -e

bot "So what are we doing today?"
echo "1) New system setup - install everything!"
echo "2) Update dotfiles (vim, bash, etc)"
echo "3) Update OS X system prefs"
echo "4) Update OS X applications (via Homebrew)"
echo "5) Nuke it all from orbit"
echo "6) Exit"

read option

#does bash have named hashes? I'll check later
#for now, this will work.
#Tasks are, in order:
#0 - dotfiles
#1 - OS X system prefs
#2 - homebrew stuff
declare -a tasks=(0 0 0)
# TODO: set up a named array for each installation step and
# have each trigger the associated dotfile update setp
case $option in
  1)
    echo "you chose new system setup"
    tasks[0]=1
    tasks[1]=1
    tasks[2]=1
    ;;
  2)
    echo "dotfiles only"
    tasks[0]=1
    ;;
  3)
    echo "OS X system prefs"
    tasks[1]=1
    ;;
  4)
    echo "OS X applications"
    tasks[2]=1
    ;;
  5)
    echo "Nuke it from orbit"
    echo "This hasn't been implemented yet."
    exit 0
    ;;
  6)
    echo "Exit"
    exit 0
    ;;
  *)
    echo "Unrecognized option"
    exit 1
    ;;
esac

#bash and command line setup

# vim setup
if [ ${tasks[0]} = 1 ]; then
  ./vim-setup.sh
fi

# os x setup
if [ ${tasks[1]} = 1 ]; then
  bot "Setting up sensible OS X defaults"
  pushd osx >/dev/null 2>&1
  sudo ./set_defaults.sh
  popd >/dev/null 2>&1
  #xcode-select --install install command line tools as part of dotfiles setup?
  ok "OS X defaults are finished\n\tYou will definitely need to restart for most of these to take effect."
fi

# application download and homebrew stuff
if [ ${tasks[2]} = 1 ]; then
  # homebrew or apt-get (in a far off universe where I may possibly choose a Ubuntu machine again)
  PLATFORM="$(uname -s)"
  case "$(uname -s)" in
    "Darwin")
      echo "You're running OS X. This is good."
      bot "Setting up Homebrew and those bits"
      # I know, I know. installing arbitrary stuff pulled via curl is bad news bears
      if test $(which brew)
      then
        ok "Homebrew already installed"
      else
        action "Installing Homebrew now"
        echo "Soon this will install homebrew for you"
        install_homebrew
      fi
      action "Installing homebrew packages"
      #TODO: Ask if this is a full install (include personal apps) or a "work"
      #      install, and I only want to install the essentials
      #      Would be nice to save this as a preference (envvar?) and rely on that
      #      as a default for runs of this command at a later time.
      install_brews
      install_casks
      ok "Finished with Homebrew and brews"
      ;;
    "Linux")
      echo "You're running linux… good for you I guess?"
      # this should use apt-get instead, but we'll worry about that later, if ever
      ;;
  esac
fi

#TODO: install good ruby gems/tools like rvm or rbenv (I forget which one is en vouge and the current golden child.
# look at: http://zanshin.net/2012/08/03/adding-sublime-text-2-settings-themes-plugins-to-dotfiles/
#sublime text prefs
#bot "Setting up Sublime Text prefs, if you're in to that kind of thing"

warn "You have one job to do manually.\nAdd \"[[ -r ~/.bashrc ]] && . ~/.bashrc\" to your ~/.bash_profile file in order to get all the alias and function goodies."
echo '[[ -r ~/.bashrc  ]] && . ~/.bashrc' >> ~/.bash_profile
echo 'eval #$(rbenv init -)"' >> ~/.bash_profile
bot "Everything is done! Congrats"
