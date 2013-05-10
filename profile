# fix colours for solarized terminal
# set grep colour
export GREP_COLOR='31'

# enable syntax highlighting in less
export PAGER="less"
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS=' -R '

# export PATHs
export PATH=$PATH:$HOME/.local/bin
export CDPATH=$CDPATH:$HOME/Semester
export PYTHONPATH=/usr/lib/python3.3/site-packages

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


