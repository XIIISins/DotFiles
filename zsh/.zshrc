#==============================================================
#
# C O N F I G U R A T I O N  F O R  Z S H
#

#=-=-=-=-=-=-=
# load stuffs
#=-=-=-=-=-=-=

autoload -U colors && colors
autoload -U compinit && compinit
autoload -U vcs_info && vcs_info

zmodload zsh/complist
zmodload zsh/terminfo

# setopt
setopt \
  autocd \
  ksh_glob \
  extendedglob \
  prompt_subst \
  inc_append_history

bindkey -v

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Import seperate config files
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [ -e $(readlink "$HOME/.sentiarc") ]; then
  source $HOME/.sentiarc
fi

for r in $HOME/.zsh/*.zsh; do
  if [[ $DEBUG > 0 ]]; then
    echo "zsh: sourcing $r"
  fi
  source $r
done

if [ -e $HOME/.dircolors ]; then
  eval $( dircolors -b $HOME/.dircolors)
  export LS_COLORS
else
  dircolors -p > ~/.dircolors
  eval $( dircolors -b $HOME/.dircolors)
  export LS_COLORS
fi

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    source "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        ssh_start_agent;
    }
else
    ssh_start_agent;
fi

#shinymotd

if [ -e $HOME/dead.letter ]; then
  echo -e "\n\nNotice: dead letter found\n\n"
  cat $HOME/dead.letter
fi

[ $[ $RANDOM % 6 ] = 0 ] &&  $HOME/bin/motd_color || $HOME/.scripts/dynmotd
login_weather
