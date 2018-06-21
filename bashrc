# this is where you want to put things that are personalized for your shell.
# since my bash_profile usually contains a lot of company/organization specific things
# that are provided by the org, this is where addons and other things that I control
# will be added.

parse_git_branch() {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ ! "${BRANCH}" == ""   ]
  then
    STAT=`parse_git_dirty`
    echo "(${BRANCH}${STAT})"
  else
    echo ""
  fi
}
# get current status of git repo
function parse_git_dirty {
  status=`git status 2>&1 | tee`
  dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
  untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
  ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
  newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
  renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
  deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
  bits=''
  if [ "${renamed}" == "0"  ]; then
    bits=">${bits}"
  fi
  if [ "${ahead}" == "0"  ]; then
    bits="*${bits}"
  fi
  if [ "${newfile}" == "0"  ]; then
    bits="${bits}"
  fi
  if [ "${untracked}" == "0"  ]; then
    bits="?${bits}"
  fi
  if [ "${deleted}" == "0"  ]; then
    bits="x${bits}"
  fi
  if [ "${dirty}" == "0"  ]; then
    bits="!${bits}"
  fi
  if [ ! "${bits}" == ""  ]; then
    echo " ${bits}"
  else
    echo ""
  fi
}


PS1="[\t \u \W \w]\n\`parse_git_branch\`⚡ "
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
export PATH="/usr/local/sbin:$PATH" #some tools installed by homebrew put things in that location

source ~/.functions
source ~/.aliases
source ~/.bash_terminal_colours
