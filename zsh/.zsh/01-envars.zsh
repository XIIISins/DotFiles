# HOMEs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/etc/cache"
export XDG_DATA_HOME="$HOME/var"
export GNUPGHOME="$HOME/etc/gnupg/"
export DEVEL_HOME="$HOME/dev"

# Script Paths
export BIN_HOME="$HOME/bin"
export RB_BIN="$HOME/.gem/ruby/2.4.0/bin"
export LO_BIN="$HOME/.local/bin"
#export GOPATH="$HOME/dev/src/study/Go"
export GOPATH="$HOME/go"
export GO_BIN="$HOME/go/bin"
export JS_BIN="$HOME/node_modules/"

# Env
export SSH_ENV="$HOME/.ssh/environment"

export LANG="en_US.UTF-8"

export PATH="$PATH:$GO_BIN:$LO_BIN:$BIN_HOME:$RB_BIN:$JS_BIN:/sbin:/usr/sbin:/usr/local/bin"

# JAVA
#export LD_LIBRARY_PATH=/usr/lib/jre1.7.0/lib/amd64
export LD_LIBRARY_PATH=/opt/jre1.6.0_29/lib/

export HISTSIZE=9000
export SAVEHIST=9000
export HISTFILE=$HOME/.zsh/history

export SHELL='/bin/zsh'
export EDITOR='vim'
#export MANPAGER='vimpager'

export DATE=$(date +"%F_%H%M")

# VPN Settings
# source ~/.echovpn

