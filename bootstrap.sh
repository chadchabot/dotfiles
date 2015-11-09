#!/bin/bash
# inspired by everyone else who's ever done such a thing, but mostly Paul Vilchez
# who turned me on to this whole dotfiles thing, unbeknownst to him

source ./lib.sh

set -e


#TODO: check if this is an 'update' or 'complete' install
#      which will let us skip a lot of the application downloading and OS X system
#      pref steps.
bot "Setting up your dotfiles for you, you handsome bastard."

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUNDLE_DIR="${BASE_DIR}/vim/bundle"
BACKUP_DIR="${BASE_DIR}/vim/backup"
AUTOLOAD_DIR="${BASE_DIR}/vim/autoload"

MY_NAME="$(whoami)"

bot "Starting with Vim bits"
action "cleaning up vim directives"
#vim dir setup
if [ -L ~/.vim ]; then #is ~/.vim a symlink
  rm ~/.vim
elif [ -d ~/.vim ]; then #is ~/.vim a directory
  mv ~/.vim ~/.vim-old
fi

ln -Fs ${BASE_DIR}/vimrc ~/.vimrc #this is hella basic, but should suffice for now
# I don't want to symlink this dir, I want to create and do the installation of stuff on this machine, not carry around the config... right?
ln -Fs ${BASE_DIR}/vim/ ~/.vim
#don't forget about neovim!
ln -Fs ${BASE_DIR}/vimrc ~/.nvimrc
ln -Fs ${BASE_DIR}/vim/ ~/.nvim

action "Setting up vim directories"
#does the DIR exist? if not, create it
[ -d $BACKUP_DIR ]   || mkdir -p $BACKUP_DIR
[ -d $BUNDLE_DIR ]   || mkdir -p $BUNDLE_DIR
[ -d $AUTOLOAD_DIR ] || mkdir -p $AUTOLOAD_DIR

if [ -f ~/.vim/autoload/pathogen.vim ]; then
  ok "Pathogen already installed"
else
  action "Downloading pathogen..."
  PATHOGEN_DEST="${AUTOLOAD_DIR}/pathogen.vim"
  #TODO: I should totally be checking for completion of this
  curl -LSso $PATHOGEN_DEST https://tpo.pe/pathogen.vim
  ok "Pathogen download complete"
fi

#TODO: break this out into its own file
#install vim bundles
action "Installing NERDTree"
declare -a nerd_tree=("NERDTree file navigation" "https://github.com/scrooloose/nerdtree.git")
get_vim_bundle $BUNDLE_DIR "${nerd_tree[0]}" "${nerd_tree[1]}"
warn "Don't forget to run :Helptags when you first run vim!"

action "Installing Fugitive"
declare -a fugitive=("Fugitive Git plugin" "git://github.com/tpope/vim-fugitive.git")
get_vim_bundle $BUNDLE_DIR "${fugitive[0]}" "${fugitive[1]}"

action "Installing Solarized theme"
declare -a solarized_theme=("Solarized theme" "https://github.com/altercation/vim-colors-solarized.git")
get_vim_bundle $BUNDLE_DIR "${solarized_theme[0]}" "${solarized_theme[1]}"

action "Installing syntax packages"
declare -a coffeescript_syntax=("Vim Coffeescript syntax package" "https://github.com/kchmck/vim-coffee-script.git")
get_vim_bundle $BUNDLE_DIR "${coffeescript_syntax[0]}" "${coffeescript_syntax[1]}"

declare -a arduino_syntax=("Arduino syntax package" "https://github.com/sudar/vim-arduino-syntax.git")
get_vim_bundle $BUNDLE_DIR "${arduino_syntax[0]}" "${arduino_syntax[1]}"

declare -a less_syntax=("Less syntax package" "https://github.com/groenewege/vim-less.git")
get_vim_bundle $BUNDLE_DIR "${less_syntax[0]}" "${less_syntax[1]}"

action "Installing vim-airline status bar tool"
declare -a airline_tool=("Vim Airline status bar tool" "https://github.com/bling/vim-airline.git")
get_vim_bundle $BUNDLE_DIR "${airline_tool[0]}" "${airline_tool[1]}"

action "Installing vim indent guide tool"
declare -a indent_guide=("Vim Indent Guides" "https://github.com/nathanaelkane/vim-indent-guides.git")
get_vim_bundle $BUNDLE_DIR "${indent_guide[0]}" "${indent_guide[1]}"

bot "Setting up Git preferences"
move_and_symlink ~/.gitconfig ${BASE_DIR}/gitconfig
if [ -f ~/.gitconfig ]; then
  mv ~/.gitconfig ~/.gitconfig-old
fi
ln -s ${BASE_DIR}/gitconfig ~/.gitconfig
ln -Fs ${BASE_DIR}/gitmessage ~/.gitmessage
ok "Finished setting up git prefs"

#terminal prefs (what's the difference between input and bash_profile prefs?)
bot "Setting up terminal prefs"
move_and_symlink ~/.inputrc ${BASE_DIR}/inputrc
move_and_symlink ~/.bashrc ${BASE_DIR}/bashrc

bot "Setting up terminal extras"
move_and_symlink ~/.functions ${BASE_DIR}/functions.sh
move_and_symlink ~/.aliases ${BASE_DIR}/aliases.sh

ok "Finished with terminal prefs"

# determine the platform you're using, which will determine whether we use
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
    install_brews
    install_casks #once I'm sure that this is a good thing, I'll turn it on, but it needs to do things like check whether those applications are already installed and other checks.
    #maybe move that stuff over to a "first run" type script, because so far bootstrap.sh can be used almost any time, anywhere, with little to no bad news
    ok "Finished with Homebrew and brews"
    bot "Setting up sensible OS X defaults"
    sh ./osx/set_defaults.sh
    ;;
  "Linux")
    echo "You're running linux… good for you I guess?"
    # this should use apt-get instead, but we'll worry about that later, if ever
    ;;
esac

#TODO: install good ruby gems/tools like rvm or rbenv (I forget which one is en vouge and the current golden child.
# look at: http://zanshin.net/2012/08/03/adding-sublime-text-2-settings-themes-plugins-to-dotfiles/
#sublime text prefs
#bot "Setting up Sublime Text prefs, if you're in to that kind of thing"

warn "You have one job to do manually.\nAdd \"[[ -r ~/.bashrc ]] && . ~/.bashrc\" to your ~/.bash_profile file in order to get all the alias and function goodies."

bot "Everything is done! Congrats"
