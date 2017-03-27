#!/bin/bash
#create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

function pushd_quiet() {
  pushd "$1" >/dev/null 2>&1
}

function popd_quiet() {
  popd >/dev/null 2>&1
}

#typing pbpaste & pbcopy is a pain.
#I think what this does is checks if there's anything in the clipboard, and
#paste it if it is, else copy what follows
function clip() {
  [ -t 0 ] && pbpaste || pbcopy;
}

#using arcanist? Then you may end up with a bunch of branches named
#Arcpath-XXX-N littering your repos
#delete them from your local repo with this
function clean_arcpatch(){
  if test ! "$(which git)"
  then
    echo "Git is not installed. What is wrong with you?"
    exit
  fi
  for ref in $(git for-each-ref --format='%(refname)' refs/heads/arcpatch*); do
    branch_name=$(echo "$ref" | cut -f 3 -d '/')
    echo $(git branch -D $branch_name)
  done
}

function clean_hotfixes(){
  if test ! "$(which git)"
  then
    echo "Git is not installed. What is wrong with you?"
    exit
  fi
  branches=$(git for-each-ref --format='%(refname)' refs/heads/hotfix*)
  branch_count=${#branches[@]}
  echo "There were ${branch_count} branches found."
  echo "${branches[@]}"
  #why is this returning an array of length 1, but the first entry is an empty string?
  echo "|${branches[0]}|"
  exit 1
  #TODO: count number of refs that match, and how many are deleted
  #TODO: if there are no branches matching the name/pattern, say so
  for ref in $branches; do
    branch_name=$(echo "$ref" | cut -f 3 -d '/')
    $(git branch -D "$branch_name")
  done
}

#TODO: allow
function grb() {
  #commit_range = [[ -n $2 ]]
  # conditionally assign value to commit_range if one is supplied via function args
  #echo `git rebase --interactive HEAD~${commit_range}`
  exit 0
}

#TODO: a function to go through, branch by branch, and delete, skip, or quit
#      which would make it easier to delete multiple git branches with one command.
#      Very similar to how `git add -p` works, allowing you to choose which changes
#      will be staged for commit
function clean_branches() {
  exit 0
}

#should operate very similar to pushd
#allow you to switch between git branches quickly
function pushbr(){
  #TODO: where/how does pushd/popd store the directory stack?
  #Cheat by putting it in an environment variable for now?
  #
  # verify that destination branch exists
    # lookup in local branches
  # stash current changes
  # store the id/ref of the stash
  # get current branch name
  # switch to branch specified by arg
  #
  #http://stackoverflow.com/questions/9916551/pushd-popd-global-directory-stac
  echo "pushbr()"
}

#should operate very similar to pushd
#allow you to switch between git branches quickly
function popbr(){
  # reverse of pushbr
  echo "popbr()"
}

# far too clever way to do what should be a simple task
# TODO: make sure this works!
function open_files_matching(){
  SEARCH_REGEX=$1
  SEARCH_PATH=$2
  #TODO: only open if there are matches, else give an error message
  #TODO: why is this failing on a "ag: command not found" error?
  FILE_LIST=$(ag -l "$SEARCH_REGEX" "$SEARCH_PATH")
  echo "$FILE_LIST"
  #| xargs -o vim -p
}

#TODO quick conversion from hex to decimal for colours, and vice-versa
#     though this is probably more fun to write in ruby or python
#

#colourized man pages
# http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
man() {
  env \
    LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
    LESS_TERMCAP_md="$(printf "\e[1;31m")" \
    LESS_TERMCAP_me="$(printf "\e[0m")" \
    LESS_TERMCAP_se="$(printf "\e[0m")" \
    LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
    LESS_TERMCAP_ue="$(printf "\e[0m")" \
    LESS_TERMCAP_us="$(printf "\e[1;32m")" \
      man "$@"
}
