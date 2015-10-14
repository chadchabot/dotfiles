alias p="pushd"
alias o="popd"

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

alias v="vim"
alias j="jobs"
alias f="fg"
#what about a function where I type in a number and that job is brought to the foreground?
# so typing `$ 2` would be equivalent to `$ fg 2`, but only if that job existed

alias phonesim="/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/Contents/MacOS/Simulator"

alias fs="stat -f \"%z bytes\"" #get the size of a file

#grab just the headers from curl
alias icurl="curl -I"

alias hosts="vim /etc/hosts"

#use quicklook from the command line
alias ql="qlmanage -p"

#typos
alias gti=git
alias brwe=brew
alias where=which

#IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
