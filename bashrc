# ~/.bashrc: executed by bash(2) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# history setting  {{{
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILE="$HOME/.bash_history"
HISTSIZE=100000
HISTFILESIZE=200000

# }}}

# misc {{{

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# fix this later and put it in profile
if [ "$TERM" = "linux" ] && false ; then
    echo -en "\e]P0222222" #black
    echo -en "\e]P8222222" #darkgrey
    echo -en "\e]P1803232" #darkred
    echo -en "\e]P9982b2b" #red
    echo -en "\e]P25b762f" #darkgreen
    echo -en "\e]PA89b83f" #green
    echo -en "\e]P3aa9943" #brown
    echo -en "\e]PBefef60" #yellow
    echo -en "\e]P4324c80" #darkblue
    echo -en "\e]PC2b4f98" #blue
    echo -en "\e]P5706c9a" #darkmagenta
    echo -en "\e]PD826ab1" #magenta
    echo -en "\e]P692b19e" #darkcyan
    echo -en "\e]PEa1cdcd" #cyan
    echo -en "\e]P7ffffff" #lightgrey
    echo -en "\e]PFdedede" #white
    clear #for background artifacting
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] \
            && echo terminal || echo error)" "$(history | tail -n1 | \
            sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# }}}

# aliases {{{

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.


# }}}

# functions {{{
function __truncPwd() {
    pwd | sed "s:^$HOME:~:" | awk -F/ '{print (NF<=3)?$0:$(NF - 1)"/"$NF}'
}

function source() {
    [ $# -eq 0 ] && builtin source $HOME/.bashrc || builtin source $@
}

# }}}

# prompt {{{
__prompt_command() {
    [ $? -eq 0 ] || local PS1_END_COL="\[\033[01;31m\]"

    PS1="\[\033[1m\]\s "
    PS1+="\[\033[00;31m\]\u\[\033[00m\]@\[\033[0;32m\]\h "
    PS1+="\[\033[00m\]$(__truncPwd) "

    PS1+="\[\033[01;35m\]${PS1_END_COL}»\[\033[00m\] "
    export PS1
}
PROMPT_COMMAND=__prompt_command

# }}}

for file in ".aliases" ".functions"; do
    [ -f "$HOME/$file" ] && . "$HOME/$file"
done
