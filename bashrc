# this is where you want to put things that are personalized for your shell.
# since my bash_profile usually contains a lot of company/organization specific things
# that are provided by the org, this is where addons and other things that I control
# will be added.

#PS1='[\t \u \W \w]\n⚡'
#(user@host) [directory][# of active jobs]
#TODO: ask the user if they want to use this custom prompt as part of the bootstrap process
# if ENV_VAR[FOO] == BAR; do
#PS1='(\[\e[4;32m\]\u\[\e[0m\]@\[\e[1;34m\]\h\[\e[0m\]) [\[\e[0;31m\]\W\[\e[0m\]][\j] \$: '
#fi
#autocorrect minor typos when using 'cd'
shopt -s cdspell;

export EDITOR=vim
export VISUAL=vim


#specify your defaults in this environment variable
#I want apps installed via cask to be available to all users, don't I?
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_101.jdk/Contents/Home
export PATH=/opt/apache-maven-3.3.9/bin:$PATH

source ~/.functions
source ~/.aliases
source ~/.bash_term_colours
