Dotfiles
=======
These contain my configurations for some of the applications I use.

TO-DO
=====
- Fix the `zshrc` prompt so that it is faster
- Fix the `zshrc` prompt so that it uses the `prompt` command

Installation
============
cd into this directory
```
for file in _*; do ln -s $PWD/$file $HOME/${file/_/.}; done
```
