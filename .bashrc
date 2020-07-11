#!/usr/bin/env bash

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Path to the bash it configuration
export BASH_IT="/home/lion/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
export BASH_IT_THEME='standard'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
# export BASH_IT_RELOAD_LEGACY=1

# Load Bash It
source "$BASH_IT"/bash_it.sh

alias v="nvim"
alias vim="nvim"
#alias qtc="(qtcreator . &>/dev/null &)"

alias rm="rm -v"
alias cp="cp -v"
alias mv="mv -v"

qtc() {
    (qtcreator "$1" &>/dev/null &)
}

qtfiles() {
    git ls-files "*.c" "*.h" "*.cpp" "*.hpp" "*.hh" "*.cc" "Makefile" "CMakeLists.txt";
}

git_branch() {
    branch="$(git describe --contains --all HEAD 2>/dev/null)"; 
    [ ${#branch} -eq 0 ] && echo "" || echo " : ${branch}"
}

export PREV_COMMAND=""

set_xterm_title () {
    if [ "$1" != "prompt_command" ]; then
        export PREV_COMMAND=$1;
    fi
    local title="$PREV_COMMAND : $(lk_short_path)"
    echo -ne "\033]0;$title\007"
}

stdman() {
    man std::"$1";
}

# includes git branch (slow)
# export PS1="\[\033[32m\]\$(lk_short_path)\[\033[33m\]\$(git_branch)\[\033[00m\] \$ "

export PS1="\[\033[32m\]\$(lk_short_path)\[\033[33m\]\[\033[00m\] \$ "

#trap 'set_xterm_title "$BASH_COMMAND"' DEBUG

clear

function ydl() {
        local dir="music_`date +%s`";
        mkdir $dir;
        cd $dir;
        youtube-dl --yes-playlist -x -i --audio-format mp3 "$@";
        zip -v -9 $dir.zip *.mp3;
        echo "saving as $dir.zip";
        curl -v https://bashupload.com/$dir.zip --data-binary @$dir.zip;
        cd ..;
        echo "output dir: $dir";
}

function unix_time() { 
    date +%s;
}

function vtmp() {
    local filename="/tmp/$(unix_time).$1";
    echo "edited $filename";
    nvim $filename;
}

function do_title_thing() {
    set_xterm_title $BASH_COMMAND;
}

trap do_title_thing DEBUG
