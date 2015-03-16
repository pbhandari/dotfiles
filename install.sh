#!/usr/bin/bash

for file in _*; do
    if [[ -e $HOME/${file/_/.} ]]; then
        echo "$HOME/${file/_/.} already exists" >&2
    else
        ln -s $PWD/$file $HOME/${file/_/.}
    fi
done

git submodule update --init
