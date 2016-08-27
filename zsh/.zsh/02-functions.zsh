# {{{ Title stuffs
precmd() {

	vcs_info
	setprompt

	case $TERM in
		rxvt-256color | screen-256color ) 
			print -Pn "\e]0;%n@%m: %~\a" ;;
	esac
}

preexec() {
	case $TERM in
		rxvt-256color | screen-256color )
			print -Pn "\e]0;$1\a" ;;
	esac
} # }}}

# {{{ Oneliners
goto() { [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }
cpf() { cp "$@" && goto "$_"; }
mvf() { mv "$@" && goto "$_"; }
mkf() { mkdir -p $1; cd $1 }
cdl() { cd $@; ls++ }
d() { ($1 &) }
zsh_stats() { history | awk '{print $2}' | sort | uniq -c | sort -rn | head }
du1() { du -h --max-depth=1 "$@" | sort -k 1,1hr -k 2,2f; }
epoch() { print $(( `echo $1 | cut -b 1-2` * 3600 + `echo $1 | cut -b 4-5` * 60 + `echo $1 | cut -b 7-8` )) }
tfonts() { for i in ${TOILET_FONT_PATH:=/usr/share/figlet}/*.{t,f}lf; do j=${i##*/}; toilet -d "${i%/*}" -f "$j" "${j%.*}"; done }
ydl() { [ -z "$1" ] || youtube-dl -x --audio-format mp3 --audio-quality 0 "$@" }
# }}}

# {{{ Most used Commands
mostused() {
	sed -n 's/^\([a-z]*\) .*/\1/p' $HISTFILE |
	sort |
	uniq -c |
	sort -n -k1 |
	tail -25 |
	tac
} # }}}

# {{{ Setup empty github repo
mkgit() {
	mkdir $1
	cd $1
	git init
	touch README.markdown
	git add README.markdown
	git commit -m 'inital setup - automated'
	git remote add origin git@github.com:XIIISins/$1.git
	git push origin master
} # }}}

# {{{ Message of the day
shinymotd() {
if [ $(($RANDOM/$RANDOM)) -gt 0 ]; then
  colortest2
  woodo
else
  echo $(hostname) | toilet -f chunky -F gay -F border
  woodo
fi
} # }}}

# {{{ Translate
translate() {
if test -z "$1"; then
    echo "usage: $(basename $0) text"
    echo "examples:"
    echo "    $(basename $0) text"
    echo "    TL=el $(basename $0) text"
    echo "    SL=en TL=pl $(basename $0) text"
    exit 1
fi

TEXT=$1
SL=${SL:-auto}
TL=${TL:-ja}

TRANSLATEURL='https://translate.google.com/'
UA='Mozilla 5.0'
NEWLINE='\
'

# do translate
curl --user-agent "$UA" \
    --data "sl=$SL" \
    --data "tl=$TL" \
    --data-urlencode "text=$TEXT" \
    --silent $TRANSLATEURL \
    | sed "s/<\/span>/$NEWLINE/g" | grep 'result_box' | sed 's/.*>//'
}
# }}}
