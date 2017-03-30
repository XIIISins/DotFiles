#!/usr/bin/zsh
source ~/.zsh/01-envars.zsh
source ~/.zsh/02-functions.zsh
export PATH="$PATH:$HOME/.scripts"
export BSPWM_STATE="/tmp/bspwm-state.json"
export PANEL_FIFO="/tmp/panel-fifo"
#export IOUP_TOKEN="$(cat ~/.iotoken)"
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec xinit hlwm -- vt$XDG_VTNR
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec xinit hlwm 
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && /home/xiii/bin/selectwm
#[ -z $DISPLAY -a $XDG_VTNR -eq 1 -a $TTY -eq "/dev/tty1" ] && ${HOME}/bin/selectwm
#

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


#
if [[ -z $DISPLAY ]] && [[ ${XDG_VTNR:-1} -eq 1 ]] && [[ $TTY =~ "/dev/tty" ]]; then
  if [[ -e "$HOME/bin/selectwm" ]]; then
    $HOME/bin/selectwm
  fi
fi
