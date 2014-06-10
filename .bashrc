#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

BLACK='\[\033[0;30m\]'
BLUE='\[\033[0;34m\]'
GREEN='\[\033[0;32m\]'
CYAN='\[\033[0;36m\]'
RED='\[\033[0;31m\]'
PURPLE='\[\033[0;35m\]'
BROWN='\[\033[0;33m\]'
LIGHTGRAY='\[\033[0;37m\]'
DARKGRAY='\[\033[1;30m\]'
LIGHTBLUE='\[\033[1;34m\]'
LIGHTGREEN='\[\033[1;32m\]'
LIGHTCYAN='\[\033[1;36m\]'
LIGHTRED='\[\033[1;31m\]'
LIGHTPURPLE='\[\033[1;35m\]'
YELLOW='\[\033[1;33m\]'
WHITE='\[\033[1;37m\]'
NC='\[\033[0m\]'              # No Color

shopt -s checkwinsize

#PS1='[\u@\h \W]\$ '
#PS1="${NC}┌─[·${RED}\u${NC}@\h·]\n└─[\w] \$ "
#PS1="${RED}\u${NC}\[ \]${LIGHTBLUE}\w${NC}\[ \]»\[ \]"
#PS1="${RED}\u${NC}\[ \]${LIGHTBLUE}\w${NC}\[ \]${RED}>${GREEN}>${YELLOW}>${NC}\[ \]"
#PS1="\[$(tput setaf 6)\]\u \[$(tput setaf 4)\]\w \[$(tput setaf 7)\]» \[$(tput sgr0)\]"
PS1="\u ${LIGHTBLUE}\w ${YELLOW}·»${NC} "

#XResource File
xrdb ~/.Xresources

#Perl stuff
source ~/perl5/perlbrew/etc/bashrc


#Git stuff
source /usr/share/git/completion/git-completion.bash


##############
##Custom Var##
##############

dropbox=/data/Dropbox

#############
##FUNCTIONS##
#############

sys_update () {
  LOGDATE=$(date +"%Y-%m-%d")
  LOGTIMESTAMP=$(date +"%Y-%m-%d_%T")
  LOGDIR='/data/__data/LOGS'
  LOGFILE="$LOGDIR/arch_update.log"
  LOGROT=$(date +"%Y%m%d_%H%M%S")
  if [ -e $LOGFILE ]; then
    mv $LOGFILE $LOGFILE.$LOGROT
    echo "Cycling logfiles" >> $LOGFILE
    echo "Cycling logfiles"
    sudo pacman -Syu --verbose --noconfirm --logfile $LOGFILE
  else
    echo -e "\t =-=Creating logfile=-="
    touch $LOGFILE
    echo "[$LOGTIMESTAMP]=-=Creating logfile=-=" >> $LOGFILE
    sudo pacman -Syu --verbose --noconfirm --logfile $LOGFILE
  fi
}

asroot () {
  echo -n ">"
  read asroot_com

for root_com in $asroot_com; do
  su - root -c "$root_com"
done
}


#########
##ALIAS##
#########

##System Alias##

#alias pacman='sudo pacman'
#alias ls='ls --color=auto'
#alias systemctl='sudo systemctl'
#alias aur='packer -S'
#alias lock='i3lock -i .i3/lock.png'

alias ctl_rld_usr='/bin/systemctl --user daemon-reload'
alias irssi='irssi -n xiiisins'

##Other##
alias vi='vim'
alias suvi='sudo vim'
alias reboot='shutdown -r now'
alias idle='cmatrix'

##SSH##
alias zabbix='ssh mjanssen@10.31.52.18'
alias wash='wsh'
alias Y_backup='ssh mjanssen@yslxbk01'
alias sins='ssh xiii@xiiisins.com'

###-------------------###
###WORK SPECIFIC ALIAS###
###-------------------###
wsh () {
if [ $USER == 'xiii' ]; then
	ssh mjanssen@$1
elif [ $USER == 'root' ]; then
	ssh mjanssen@$1
else
	ssh $1
fi
}

if [ $[RANDOM % $(ps -ef|grep $(if [[ $TERM == "rxvt-unicode-256color" ]]; then echo "urxvt"; else echo "$TERM"; fi) | wc -l )] == 0 ]; then
	space_invaders
	echo "reinvent transparent portals"
else
	echo "  _________.__         .__              .__        ";
	echo " /   _____/|  |   ____ |__|_____   ____ |__|______ ";
	echo " \_____  \ |  | _/ __ \|  \____ \ /    \|  \_  __ \\";
	echo " /        \|  |_\  ___/|  |  |_> >   |  \  ||  | \/";
	echo "/_______  /|____/\___  >__|   __/|___|  /__||__|   ";
	echo "        \/           \/   |__|        \/           ";
	fortune
fi

