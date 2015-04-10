# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="norm"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux wd)

source $ZSH/oh-my-zsh.sh

#. /usr/share/zsh/site-contrib/powerline.zsh

#source $HOME/.oh-my-zsh/plugins/autojump/autojump.plugin.zsh

# User configuration

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Unicode
setopt printeightbit

# mv zsh
autoload zmv

# Colors
LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:ow=34;01:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:';
export LS_COLORS
export ZLS_COLORS=$LS_COLORS

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [ -e ${HOME}/.zsh_function ]; then
    source ${HOME}/.zsh_function
fi

if [ -e ${HOME}/.zsh_alias ]; then
    source ${HOME}/.zsh_alias
fi

if [ -e ${HOME}/.yenlorc ]; then
    source ${HOME}/.yenlorc
fi

# X Terminal titles
case $TERM in
    *xterm*|rxvt|rxvt-unicode|rxvt-256color|(dt|k|E)term)
        precmd () { print -Pn "\e]0;$TERM - [%n@%M]%# [%~]\a" } 
        preexec () { print -Pn "\e]0;$TERM - [%n@%M]%# [%~] ($1)\a" }
    ;;
    screen)
        precmd () { 
            print -Pn "\e]83;title \"$1\"\a" 
            print -Pn "\e]0;$TERM - [%n@%M]%# [%~]\a" 
        }
        preexec () { 
            print -Pn "\e]83;title \"$1\"\a" 
            print -Pn "\e]0;$TERM - [%n@%M]%# [%~] ($1)\a" 
        }
    ;; 
esac

autoload zkbd
[[ ! -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE ]] && zkbd
source ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE

[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

#bindkey -m

# Pager
export PAGER=/usr/bin/less
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

###############
# AUTOLOCKING #
###############
#export TMOUT=300
function TRAPALRM() { vlock-cmatrixreloaded }

#TMUX_C=`ps -aux | awk '{print $7}' | sed 's/\?//' | sed 's/TTY//' | sed '/^\s*$/d' | sort -u | wc -l`
#COW=`ls /usr/share/cows/ | shuf -n1`
#if [ $((RANDOM % 2)) -eq "0" ]; then
#    clear;
#    echo "  _________.__         .__              .__        ";
#    echo " /   _____/|  |   ____ |__|_____   ____ |__|______ ";
#    echo " \_____  \ |  | _/ __ \|  \____ \ /    \|  \_  __ \\";
#    echo " /        \|  |_\  ___/|  |  |_> >   |  \  ||  | \/";
#    echo "/_______  /|____/\___  >__|   __/|___|  /__||__|   ";
#    echo "        \/           \/   |__|        \/           ";
#    alsi -l
#else
#    clear;alsi -f;fortune -s
#fi

if [ -e /tmp/xiii.zsh_op ]; then
    clear
    alsi -l
    echo "▬▬▬▬▬▬▬▬▬▬ஜ۩۞۩ஜ▬▬▬▬▬▬▬▬▬"
    echo "     ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄      "
    echo "     ████▌▄▌▄▐▐▌█████      "
    echo "     ████▌▄▌▄▐▐▌▀████      "
    echo "     ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀      "
    echo "▬▬▬▬▬▬▬▬▬▬ஜ۩۞۩ஜ▬▬▬▬▬▬▬▬▬"
    rm /tmp/xiii.zsh_op
else
    clear
    alsi -l
    # echo "  _________.__         .__              .__        ";
    # echo " /   _____/|  |   ____ |__|_____   ____ |__|______ ";
    # echo " \_____  \ |  | _/ __ \|  \____ \ /    \|  \_  __ \\";
    # echo " /        \|  |_\  ___/|  |  |_> >   |  \  ||  | \/";
    # echo "/_______  /|____/\___  >__|   __/|___|  /__||__|   ";
    # echo "        \/           \/   |__|        \/           ";
    echo "▬▬▬▬▬▬▬▬▬▬ஜ۩۞۩ஜ▬▬▬▬▬▬▬▬▬"
    echo "   ╠╬╬╬╣                  "
    echo "   ╠╬╬╬╣OK! WHO ATE MY    "
    echo "   ╠╬╬╬╣CHOCOLATE!?!?     "
    echo "   ╚╩╩╩╝                  "
    echo "▬▬▬▬▬▬▬▬▬▬ஜ۩۞۩ஜ▬▬▬▬▬▬▬▬▬"
    touch /tmp/xiii.zsh_op
fi
