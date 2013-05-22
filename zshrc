# Path to your oh-my-zsh configuration.
[ -r $HOME/.oh-my-zsh/oh-my-zsh.sh ] && . $HOME/.oh-my-zsh/oh-my-zsh.sh

# zsh setopts {{{
setopt AUTO_CD
setopt CDABLE_VARS

setopt AUTO_NAME_DIRS
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS # IGNORE DUPLICATION COMMAND HISTORY LIST
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY # SHARE COMMAND HISTORY DATA

setopt INTERACTIVE_COMMENTS

setopt LONG_LIST_JOBS
setopt NO_HUP
setopt NO_MAIL_WARNING
# }}}

# autoloads {{{
autoload -U colors && colors
autoload -U compinit && compinit -i
autoload -U zcalc

# edit the commandline
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
# }}}

# keybindings {{{
bindkey -v
bindkey '\ew' kill-region
bindkey -s '\el' "ls\n"
bindkey '^r' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

# make search up and down work, so partially type and hit up/down to find
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey "^[[H" beginning-of-line
bindkey "^[[F"  end-of-line

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# gnome-terminal
bindkey "^[OF" end-of-line
bindkey "^[OH" beginning-of-line
# urxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey '^[[Z' reverse-menu-complete

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

# file rename magick
bindkey "^[m" copy-prev-shell-word
# }}}

# extra files {{{
# aliases and functions global for all shells
for file in ".aliases" ".functions" ; do
    [ -r "$HOME/$file" ] && . "$HOME/$file"
done

# command-not-found hook
[ -r "/usr/share/doc/pkgfile/command-not-found.zsh" ] \
    && . /usr/share/doc/pkgfile/command-not-found.zsh

# }}}

# functions {{{
function expand-or-complete-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle expand-or-complete
    zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

function history() {
    [ $# -eq 0 ] && builtin history 1 || builtin history $@
}

function source() {
    [ $# -eq 0 ] && builtin source ${HOME}/.zshrc || builtin source $@
}

function stats() {
    [ "$1" ] && local NUM=$1 || local NUM=10
    local IGNORE="./|clear|tmux" # keep something in here
    fc -l 1 | awk '{CMD[$2]++;}END { for (a in CMD)print CMD[a] " " a;}'\
            | grep -v $IGNORE | column -c3 -t | sort -nr | nl | head -n $NUM
}

function cnky() {
    for i in sys mpd clock; do
        conky -c $HOME/.conky/$i/conkyrc &
    done
}

# }}}

# prompt {{{
prompt off

[ -n "$SSH_CLIENT" ] && PROMPT="%Bssh%b " || PROMPT=""
PROMPT+="%{$fg[red]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$reset_color%}%2~ "
PROMPT+="%{$fg[magenta]%}%(?..%{$fg[red]%})%B»%b%{$reset_color%} "
export PROMPT

export RPROMPT="%(?..%{$fg[red]%}%B%? ↵%b%{$reset_color%})"
# }}}

export MAILCHECK=0

# vim:foldenable:ft=zsh
