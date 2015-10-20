# this is where you want to put things that are personalized for your shell.
# since my bash_profile usually contains a lot of company/organization specific things
# that are provided by the org, this is where addons and other things that I control
# will be added.

#PS1='[\t \u \W \w]\n⚡'
#(user@host) [directory][# of active jobs]
PS1='(\[\e[4;32m\]\u\[\e[0m\]@\[\e[1;34m\]\h\[\e[0m\]) [\[\e[0;31m\]\W\[\e[0m\]][\j] \$: '

#autocorrect minor typos when using 'cd'
shopt -s cdspell;

export EDITOR=vim
export VISUAL=vim

source ~/.functions
source ~/.aliases
