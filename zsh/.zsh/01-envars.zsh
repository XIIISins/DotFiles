# HOMEs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/etc/cache"
export XDG_DATA_HOME="$HOME/var"
export GNUPGHOME="$HOME/etc/gnupg/"
export DEVEL_HOME="$HOME/dev"
export BIN_HOME="$HOME/bin"
export RB_BIN="$HOME/.gem/ruby/2.3.0/bin"

export LANG="en_US.UTF-8"

export PATH="$PATH:$BIN_HOME:$RB_BIN:/sbin:/usr/sbin:/usr/local/bin"

# JAVA
#export LD_LIBRARY_PATH=/usr/lib/jre1.7.0/lib/amd64
export LD_LIBRARY_PATH=/opt/jre1.6.0_29/lib/

export HISTSIZE=9000
export SAVEHIST=9000
export HISTFILE=$HOME/.zsh/history

export SHELL='/usr/bin/zsh'
export EDITOR='vim'
export MANPAGER='vimpager'

# VPN Settings
source ~/.echovpn
