#                 ██      
#                ░██      
#  ██████  ██████░██      
# ░░░░██  ██░░░░ ░██████  
#    ██  ░░█████ ░██░░░██ 
#   ██    ░░░░░██░██  ░██ 
#  ██████ ██████ ░██  ░██ 
# ░░░░░░ ░░░░░░  ░░   ░░  
#
#  ▓▓▓▓▓▓▓▓▓▓
# ░▓ author ▓ xero <x@xero.nu>
# ░▓ code   ▓ http://code.xero.nu/dotfiles
# ░▓ mirror ▓ http://git.io/.files
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░
#
#█▓▒░ aliases
alias xyzzy="echo nothing happens"
alias ls="ls -hF --color=auto"
alias ll="ls -lahF --color=auto"
alias lsl="ls -lhF --color=auto"
alias "cd.."="cd ../"
alias up="cd ../"
alias rmrf="rm -rf"
alias psef="ps -ef"
alias mkdir="mkdir -p"
alias cp="cp -r"
alias scp="scp -r"
alias xsel="xsel -b"
alias fuck='sudo $(fc -ln -1)'
alias v="vim"
alias vi="vim"
alias vim="nvim"
alias tree='tree -CAF -I "CVS|*.*.package|.svn|.git|.hg|node_modules|bower_components" --dirsfirst'
alias term="urxvtc -hold -e " #used for run menu
alias toiletlist='for i in ${TOILET_FONT_PATH:=/usr/share/figlet}/*.{t,f}lf; do j=${i##*/}; echo ""; echo "╓───── "$j; echo "╙────────────────────────────────────── ─ ─ "; echo ""; toilet -d "${i%/*}" -f "$j" "${j%.*}"; done'
alias lol="base64 </dev/urandom | lolcat"
alias pacman="sudo pacman"
alias update="pacman-colors && yaourt -Syua"
alias systemctl="sudo systemctl"
alias disks='echo "╓───── m o u n t . p o i n t s"; echo "╙────────────────────────────────────── ─ ─ "; lsblk -a; echo ""; echo "╓───── d i s k . u s a g e"; echo "╙────────────────────────────────────── ─ ─ "; df -h;'
alias sispwd='echo fuckyou | repass | xclip'
alias ncp='ncmpcpp -s playlist -S visualizer'

#█▓▒░ dumb tmux trix
alias tsad="printf '\033k┐(T_T)┌\033\\'"
alias tshrug="printf '\033k┐(\`-\`)┌\033\\'"
alias tlol="printf '\033k┐(^0^)┌\033\\'"

function t() {
  X=$#
  [[ $X -eq 0 ]] || X=X
  tmux new-session -A -s $X
}

# colorized cat
function c() {
  for file in "$@"
  do
    pygmentize -O style=sourcerer -f console256 -g "$file" 
  done
}
# colorized less
function l() {
  pygmentize -O style=sourcerer -f console256 -g $1 | less -r 
}
# read markdown files like manpages
function md() {
    pandoc -s -f markdown -t man "$*" | man -l -
}
# nullpointer url shortener
function short() {
  curl -F"shorten=$*" https://0x0.st
}
