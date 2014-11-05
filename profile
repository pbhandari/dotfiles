# enable syntax highlighting in less
export PAGER="less"
export LESSOPEN="| /usr/bin/lesspipe.sh %s"
export LESS=' -R -m -i'

export GIT_PAGER="less -FX"

# export PATHs
PATH="$HOME/.local/bin:$PATH"               # .local/bin

if which ruby > /dev/null 2>&1; then        # ruby gems and rvm
    PATH="$PATH:`ruby -e 'print Gem.user_dir'`/bin"
    PATH="$PATH:$HOME/.rvm/bin"
fi

if which ghci > /dev/null 2>&1; then        # haskell
    PATH="$PATH:$HOME/.cabal/bin"
fi

if which go > /dev/null 2>&1; then          # go
    export GOPATH="$HOME/.golang"
    PATH="$PATH:$GOPATH/bin"
fi

if which perl5 > /dev/null 2>&1; then       # perl
    PATH="$PATH:$HOME/.perl5/bin"
fi

export PATH
#export PYTHONPATH="/usr/lib/python3.3/site-packages"

# export maildir
export MAIL="$HOME/.mail"
export MAILCHECK=0

export EDITOR=vim
export VISUAL=$EDITOR
export BROWSER="firefox"

export LANG='en_CA.UTF-8'
export LC_COLLATE='POSIX'

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

export HISTTIMEFORMAT="%F %T "
export HISTSIZE=100000
export SAVEHIST=200000

export LSCOLORS="Gxfxcxdxbxegedabagacad"

PRAJJ_XKB_OPTS=" -model pc104"
PRAJJ_XKB_OPTS="$PRAJJ_XKB_OPTS -layout us,us -variant colemak, "
PRAJJ_XKB_OPTS="$PRAJJ_XKB_OPTS -option grp:sclk_toggle -option grp_led:scroll"
PRAJJ_XKB_OPTS="$PRAJJ_XKB_OPTS -option lv3:ralt_alt"
PRAJJ_XKB_OPTS="$PRAJJ_XKB_OPTS -option compose:paus"
PRAJJ_XKB_OPTS="$PRAJJ_XKB_OPTS -option shift:both_shiftlock"
PRAJJ_XKB_OPTS="$PRAJJ_XKB_OPTS -option altwin:swap_alt_win"
export PRAJJ_XKB_OPTS
export SESSION_FILE=${XDG_CONFIG_HOME:-${HOME}/.config}/.xsession

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${HOME}/.local/lib"

# Colourise the ttys
if [ "$TERM" = "linux" ]; then

    #echo -en "\e]P01B1D1E"
    echo -en "\e]P1F92672"
    echo -en "\e]P282B414"
    echo -en "\e]P3FD9714"
    echo -en "\e]P456C2D6"
    echo -en "\e]P5CC54FE"
    echo -en "\e]P6465447"
    echo -en "\e]P7CCCCC6"

    echo -en "\e]P8505354"
    echo -en "\e]P9FF5995"
    echo -en "\e]PAB6E354"
    echo -en "\e]PBFEEDC6"
    echo -en "\e]PC8CEDFF"
    echo -en "\e]PD8C54FE"
    echo -en "\e]PE899CA1"
    echo -en "\e]PFF8F8F2"

    clear #for background artifacting
fi

[ -f $HOME/.keychaineval ] && source $HOME/.keychaineval
