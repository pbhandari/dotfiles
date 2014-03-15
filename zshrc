
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
function history() {
    builtin history ${@:-1}
}

function source() {
    builtin source ${@:-"${HOME}/.zshrc"}
}

function stats() {
    local ignored=".\/|clear|tmux" # keep something in here
    fc -nl 1 \
        | awk '$1!~/'"$ignored"'/ {
                    CMD[$1]++;
                } END {
                    for (a in CMD)  print CMD[a] " " a;
                }'\
            | sort -nr | head -n ${1:-10} | column -c3 -t | nl
}

function cnky() {
    for i in sys mpd clock; do
        conky -c $HOME/.conky/$i/conkyrc &
    done
}

# }}}

# prompt {{{
prompt off

autoload -Uz vcs_info
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:git*' stagedstr 'M'
zstyle ':vcs_info:git*' unstagedstr 'M'
zstyle ':vcs_info:git*' check-for-changes true
zstyle ':vcs_info:git*' actionformats '(%b|%a) ' '%u%c' '%s'
zstyle ':vcs_info:git*' formats '(%b) ' '%u%c' '%s'
zstyle ':vcs_info:' enable git

precmd() {

# PS1 {{{
    # set the error code
    ps1_errno=$?

    if [ ${ps1_errno} -eq 0 ]; then
        ps1_errno=""
        line_color="%{$reset_color%}"
        ps1_tail+="%{$fg[magenta]%}"
    else
        line_color="%{$fg[red]%}"
        ps1_tail+="%{$fg[red]%}"
    fi
    ps1_tail+="%B%#%b %{$reset_color%}"

    vcs_info

    [[ "${vcs_info_msg_2_}" == "git" ]] && ps1_git=${vcs_info_msg_0_}
    [[ -n "${ps1_git}" && -n "${vcs_info_msg_1_}" ]] \
        && ps1_git_color="%{$fg[red]%}" \
        || ps1_git_color="%{$fg[green]%}"

    # initialise all the required variables
    ps1_cwd=${PWD/$HOME/\~}
    ps1_cwd_size=$((${#ps1_cwd}${ps1_git:+" + 2"} + 0))

    # print the username and hostname
    PS1=${line_color}"┌─┤ %{$fg[green]%}"${USER}
    PS1+=${line_color}"@%{$fg[blue]%}"${HOST}
    PS1+="%{$reset_color%}"${SSH_CLIENT:+"(ssh)"}${line_color}" ├"

    # fill the line until the end
    ps1_fill_size=$((${COLUMNS} - ${#USER} - ${#HOST} - ${ps1_cwd_size}\
                    ${SSH_CLIENT:+" - 5"} - 14))

    if [[ ${ps1_fill_size} < 0 ]]; then
        PS1=${line_color}"┌─"
        ps1_fill_size=$(($COLUMNS - ${ps1_cwd_size} - 9))

        if [[ ${ps1_cwd_size} -gt $(($COLUMNS - 11)) ]]; then
            ps1_cwd=...${ps1_cwd:$((12${ps1_git:+" + 2"} - $COLUMNS))}
            ps1_fill_size=0
        fi
    fi
    while ((ps1_fill_size-- > 0)); do PS1+='─'; done

    # print the working directory
    PS1+=${line_color}"┤ "${ps1_git:+"${ps1_git_color}⭠ "}
    [[ -w "$PWD" ]] && PS1+="%{$reset_color%}" || PS1+="%{$fg[red]%}"
    PS1+="${ps1_cwd}%{$reset_color%} ${line_color}├─┐"


    PS1+=$'\n'"%{${line_color}%}└─ "
    PS1+="${ps1_git_color}${ps1_git}${ps1_tail}%{$reset_color%}"

    RPS1="%{${line_color}%}%{%B%}${ps1_errno}%{%b%}"
    RPS1+="%{${line_color}%} ─┘%{$reset_color%}"

    unset ps1_errno ps1_fill_size line_color ps1_tail
    unset ps1_cwd ps1_cwd_size ps1_git ps1_git_color
# }}}

}

# secondary prompt, printed when the shell needs more information to complete a
# command.
PS2='%_> '
# selection prompt used within a select loop.
PS3='?# '
# the execution trace prompt (setopt xtrace). default: '+%N:%i>'
PS4='+%N:%i:%_> '

# }}}

export MAILCHECK=0

# vim:foldenable:ft=zsh
