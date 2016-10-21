#relies on functions.sh being sourced
alias p="pushd_quiet"
alias o="popd_quiet"

alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

#pretty ls output
alias l.="ls -dG .*"
alias ll="ls -lG"
alias ls="ls -G"
#list only directories
alias lsd="ls -l | grep "^d""

alias grep="grep --color"

#run last command again
#I know, it's dumb and more typing, but it's friendly
alias again="!!"
#run last command as sudo
alias plz="sudo !!"

#TODO: add something to help list git aliases?
#http://stackoverflow.com/questions/7066325/list-git-aliases#11613251

#shortcuts
alias g="git"
alias gb="git branch"
alias gcb="git checkout -b"
alias gco="git checkout"
alias glg="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

#alias v="vim"
alias v="/usr/local/Cellar/macvim/7.4-104/MacVim.app/Contents/MacOS/Vim"
alias n="nvim" #maybe I want to always redirect to nvim from vim?
alias j="jobs -l"
alias f="fg"
alias h="history"
alias todo='$EDITOR ~/.todo'
#what about a function where I type in a number and that job is brought to the foreground?
# so typing `$ 2` would be equivalent to `$ fg 2`, but only if that job existed

alias phonesim="/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/Contents/MacOS/Simulator"

alias fs="stat -f \"%z bytes\"" #get the size of a file

#grab just the headers from curl
alias icurl="curl -I"

alias hosts="vim /etc/hosts"

#use quicklook from the command line
alias ql="qlmanage -p"

#human readable sizes
alias df="df -H"
alias du="du -ch"

#typos
alias gti=git
alias brwe=brew
alias where=which

alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

#IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s"
alias wifion="networksetup -setairportpower airport on"
alias wifioff="networksetup -setairportpower airport off"

alias ss="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"

alias netwtf="sudo /usr/local/Cellar/"
