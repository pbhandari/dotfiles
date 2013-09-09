# fix colours for solarized terminal
# set grep colour
export GREP_COLOR='31'

# enable syntax highlighting in less
export PAGER="less"
export LESSOPEN="| /usr/bin/lesspipe.sh %s"
export LESS=' -R -m -i'

# export PATHs
export PATH="$HOME/.local/bin:$PATH:$HOME/.local/share/os161/bin:$HOME/.cabal/bin"
export CDPATH="$CDPATH:$HOME/sem"
#export PYTHONPATH="/usr/lib/python3.3/site-packages"

eval $( keychain --eval id_rsa 79376B22 )

# export maildir
export MAIL="$HOME/.mail"
export MAILCHECK=0

export EDITOR="vim:vi:nano"
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

if [ "$TERM" = "linux" ]; then

    echo -en "\e]P01B1D1E"
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
