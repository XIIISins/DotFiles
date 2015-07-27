#
# .zshrc
#

# theme
ZSH_THEME="daveverwer"

# exports
export PAGER=/usr/bin/less
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

export ZDOTDIR=$HOME
export ZSH=$HOME/.oh-my-zsh
export PATH=$HOME/bin:$HOME/scripts:$HOME/.config/herbstluftwm:/home/xiii/.gem/ruby/2.1.0/bin:$PATH

# OpenGL
export __GL_SYNC_TO_VBLANK=1
export __GL_SYNC_DISPLAY_DEVICE=DFP-0
export __GL_THREADED_OPTIMIZATIONS=0

 # sources
source $ZSH/oh-my-zsh.sh
source $ZDOTDIR/.zshfunctions/functions

# use case-sensitive completion
CASE_SENSITIVE="true"

# enable colors for ls
DISABLE_LS_COLORS="false"

# which plugins would you like to load?
plugins=(git)

# preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='vim'
fi

# Source external files

if [ -e ${HOME}/.zsh_function ]; then
    source ${HOME}/.zsh_function
fi

if [ -e ${HOME}/.zsh_alias ]; then
    source ${HOME}/.zsh_alias
fi

if [ -e ${HOME}/.yenlorc ]; then
    source ${HOME}/.yenlorc
fi

# Welcome
WELCOME=`find /home/xiii/bin/scripts/ -name "color*" | shuf -n1`
$WELCOME
puname
