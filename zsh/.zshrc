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

source $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source $HOME/.sentiarc

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

shinymotd

if [ -e $HOME/dead.letter ]; then
  echo -e "\n\nNotice: dead letter found\n\n"
  cat $HOME/dead.letter
fi
