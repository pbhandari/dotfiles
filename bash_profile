# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
#================== ENV CHANGES =====================#
# I don't like long lines
PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH

export CDPATH="$CDPATH:~/Semester/"

