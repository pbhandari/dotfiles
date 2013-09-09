
# this only contains zsh specific loads. Everything else should be on .profile


[ -r $HOME/.profile ] && . $HOME/.profile

export HISTFILE=$HOME/.zsh_history
fpath=(${HOME}/.local/share/zsh/{functions,completions} $fpath)
export FPATH
