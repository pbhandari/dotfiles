
# zsh setopts {{{
setopt    correct
setopt    auto_menu         # show completion menu on succesive tab press
setopt    complete_in_word
setopt    always_to_end
unsetopt  menu_complete   # do not autoselect the first completion entry
unsetopt  flow_control

setopt    auto_cd
setopt    cdable_vars

setopt    auto_name_dirs
setopt    auto_pushd
setopt    pushd_ignore_dups

setopt    append_history
setopt    extended_history
setopt    hist_expire_dups_first
setopt    hist_ignore_dups # ignore duplication command history list
setopt    hist_ignore_space
setopt    hist_verify
setopt    hist_find_no_dups
setopt    hist_reduce_blanks
setopt    inc_append_history
setopt    share_history # share command history data

setopt    interactive_comments

setopt    long_list_jobs
setopt    no_hup
setopt    no_mail_warning
# }}}

# autoloads {{{
autoload -U colors && colors
autoload -U compinit && compinit -i
autoload -U zcalc

# edit the commandline
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# setup defaults for alias -s
autoload -U zsh-mime-setup
zsh-mime-setup
# }}}

# Completion {{{

WORDCHARS=''

zmodload -i zsh/complist

zstyle ':completion:*' \
        matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' list-colors ''

zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*:*:kill:*:processes' \
        list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

zstyle ':completion:*:*:*:*:processes' \
        command "ps -u$USER -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' \
        tag-order local-directories directory-stack path-directories

# Use caching to speed things up
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ${HOME}/.cache/zsh

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        avahi bin daemon dbus ftp git http mail mpd mysql nobody ntp \
        polkitd postfix postgres root rtkit transmission usbmux uuidd

# ... unless we really want to.
zstyle '*' single-ignored show
# }}}

# extra files {{{
# aliases and functions global for all shells
for file in ".aliases" ".functions" ".zlerc" ; do
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
    builtin history "${@:-1}"
}

function source() {
    builtin source "${@:-${HOME}/.zshrc}"
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

precmd() {
    # set the error code
    PS1_ERRNO=$?

    if [ ${PS1_ERRNO} -eq 0 ]; then
        PS1_ERRNO=""
        LINE_COLOR="%{$reset_color%}"
        PS1_TAIL+="%{$fg[magenta]%}"
    else
        LINE_COLOR="%{$fg[red]%}"
        PS1_TAIL+="%{$fg[red]%}"
    fi
    PS1_TAIL+="%B%#%b %{$reset_color%}"

    PS1_GIT="$(parse_git_branch 2>/dev/null)"
    [ "$(git status --porcelain 2>/dev/null)" ] \
        && PS1_GIT_COLOR="%{$fg[red]%}" \
        || PS1_GIT_COLOR="%{$fg[green]%}"

    # initialise all the required variables
    PS1_CWD=${PWD/$HOME/\~}

    # print the username and hostname
    PS1_TOP=${LINE_COLOR}"┌─┤ %{$fg[green]%}"${USER}
    PS1_TOP+=${LINE_COLOR}"@%{$fg[blue]%}"${HOST}
    PS1_TOP+="%{$reset_color%}"${SSH_CLIENT:+"(ssh)"}${LINE_COLOR}" ├"

    # fill the line until the end
    PS1_FILL_SIZE=$((${COLUMNS} - ${#USER} - ${#HOST} - ${#PS1_CWD}\
                    ${SSH_CLIENT:+" - 5"} ${PS1_GIT:+" - 2"} - 14))

    if [[ ${PS1_FILL_SIZE} -lt 0 ]]; then
        PS1_TOP=${LINE_COLOR}"┌─"
        PS1_FILL_SIZE=$(($COLUMNS - ${#PS1_CWD} - 11))

        if [ ${#PS1_CWD} -gt $(($COLUMNS - 11)) ]; then
            PS1_CWD=...${PS1_CWD:$((14 - $COLUMNS))}
            PS1_FILL_SIZE=0
        fi
    fi
    while ((PS1_FILL_SIZE)); do
        PS1_TOP+='─'; ((PS1_FILL_SIZE=PS1_FILL_SIZE - 1))
    done

    # print the working directory
    PS1_TOP+=${LINE_COLOR}"┤ "${PS1_GIT:+"${PS1_GIT_COLOR}⭠ "}
    PS1_TOP+="%{$reset_color%}${PS1_CWD} ${LINE_COLOR}├─┐"


    PS1="${PS1_TOP}"$'\n'"%{${LINE_COLOR}%}└─ "
    PS1+="${PS1_GIT_COLOR}${PS1_GIT:+"($PS1_GIT) "}${PS1_TAIL}%{$reset_color%}"

    RPS1="%{${LINE_COLOR}%}%{%B%}${PS1_ERRNO}%{%b%}"
    RPS1+="%{${LINE_COLOR}%} ─┘%{$reset_color%}"

    unset PS1_ERRNO PS1_FILL_SIZE PS1_TOP LINE_COLOR PS1_TAIL\
          PS1_CWD PS1_GIT PS1_GIT_COLOR
}

# }}}

export MAILCHECK=0

# vim:foldenable:ft=zsh
