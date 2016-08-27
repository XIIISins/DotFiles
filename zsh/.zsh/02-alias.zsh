# Alias
alias vi="nvim"
alias mc='mc / \~'
alias cpr="cp -R"
alias rm='rm -v'
alias mv='mv -v'
alias cp='cp -vr'
alias c='clear'
alias e='exit'
alias x='xinit'
alias ncp='ncmpcpp'
alias scr='screen -q'
alias screen='screen -q'
alias amix='alsamixer'
alias hc="herbstclient"
alias wee='weechat-curses'
alias dir='dir --color=auto'
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'s
alias np="mpc current -f '%title% by %artist% from %album%' | xcmenu -ci"
alias shot='screenfetch -D Archlinux'
alias mkdir='mkdir -p'
alias modprobe="sudo modprobe"
alias rmmod="sudo rmmod"
alias usrrld="source ~/.zshrc"
alias flux="xflux -l 52.0248 -g 5.0918"
alias please='sudo $(fc -ln -1)'
alias MountSD="sudo mount -t vfat -o rw,uid=1000 /dev/mmcblk0p1 /mnt/sdcard"

# Grep fix
alias grep="grep $GREP_OPTIONS"
unset GREP_OPTIONS

# Weather
alias weather='curl -4 wttr.in'

# The 'ls' family (this assumes you use the GNU ls)
alias la='ls -Al'               # show hidden files
alias ls='ls --group-directories-first -hF --color'    # add colors for filetype recognition
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'        # sort by change time
alias lu='ls -lur'        # sort by access time
alias lr='ls -lR'               # recursive ls
alias lt='ls -ltr'              # sort by date
alias lm='ls -al |more'         # pipe through 'more'
alias sl='/bin/sl -aFc'     # Steam locomotive!
typeset -A key
