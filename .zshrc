#
# .zshrc
#

# theme
ZSH_THEME="daveverwer"

# exports
export ZDOTDIR=$HOME
export ZSH=$HOME/.oh-my-zsh
export PATH=$HOME/bin:$HOME/scripts:$HOME/.config/herbstluftwm:$PATH

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
   export TERM='xterm'
 else
   export EDITOR='vim'
 fi

if [ -e ${HOME}/.zsh_function ]; then
    source ${HOME}/.zsh_function
fi

if [ -e ${HOME}/.zsh_alias ]; then
    source ${HOME}/.zsh_alias
fi

if [ -e ${HOME}/.yenlorc ]; then
    source ${HOME}/.yenlorc
fi

export PAGER=/usr/bin/less
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# aliases
alias rm='rm -v'
alias mv='mv -v'
alias cp='cp -vr'
alias c='clear'
alias e='exit'
alias grep='grep --color=auto'
alias dir='dir --color=auto'
alias x='startx'
alias bm='bashmount'
alias ncp='ncmpcpp'
alias amix='alsamixer'
alias hc="herbstclient"
alias wee='weechat-curses'
alias paci='sudo pacman -S'
alias pacse='sudo pacman -Ss'
alias pacu='sudo pacman -Syu'
alias pacre='sudo pacman -R'
alias sreboot='systemctl reboot'
alias spoweroff='systemctl poweroff'
alias qwerty='setxkbmap fi; xmodmap ~/.xmodmap; xset r rate 350 45'
alias svorak='setxkbmap -layout se -variant dvorak; xmodmap ~/.xmodmap; xset r rate 350 45'
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'s
alias np="mpc current -f '%title% by %artist% from %album%' | xcmenu -ci"
alias yle='yle-dl --sublang fin --destdir ~/Downloads'
alias jwine='LC_ALL=ja_JP.utf8 wine'
alias shot='screenfetch -D Archlinux'

xset +fp /usr/share/fonts/envypn
xset fp rehash

WELCOME=`find /home/xiii/bin/scripts/ -name "color*" | shuf -n1`
$WELCOME
puname
