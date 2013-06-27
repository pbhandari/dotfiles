# fix colours for solarized terminal
# set grep colour
export GREP_COLOR='31'

# enable syntax highlighting in less
export PAGER="less"
export LESSOPEN="| /usr/bin/lesspipe.sh %s"
export LESS=' -R -m -i'

# export PATHs
export PATH="$PATH:$HOME/.local/bin:$HOME/.local/share/os161/bin"
export CDPATH="$CDPATH:$HOME/Semester"
export PYTHONPATH="/usr/lib/python3.3/site-packages"

# export maildir
export MAIL="$HOME/.mail"
export MAILCHECK=0
export EDITOR=vim
export VISUAL=$EDITOR
export BROWSER="firefox"

export LOCALE='en_CA.UTF-8'
export LC_COLLATE='C'

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

export HISTTIMEFORMAT="%F %T "
export HISTSIZE=100000
export SAVEHIST=200000

export LSCOLORS="Gxfxcxdxbxegedabagacad"

# solarized colours in linux terminal
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0073642"
    echo -en "\e]P1DC322F"
    echo -en "\e]P2719E07"
    echo -en "\e]P3B58900"
    echo -en "\e]P4268BD2"
    echo -en "\e]P5D33682"
    echo -en "\e]P62AA198"
    echo -en "\e]P7FDF6E3"

    echo -en "\e]P8002B36"
    echo -en "\e]P9CB4B16"
    echo -en "\e]PA657B83"
    echo -en "\e]PB839496"
    echo -en "\e]PC93A1A1"
    echo -en "\e]PD6C71C4"
    echo -en "\e]PEEEE8D5"
    echo -en "\e]PFFDF6E3"
    clear #for background artifacting
fi

