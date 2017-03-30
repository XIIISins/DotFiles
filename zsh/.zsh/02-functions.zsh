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

function ssh_start_agent {
    ssh_priv_key=( $(find .ssh -type f -not -name "*.pub" -name "id_rsa*") )
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    source "${SSH_ENV}" > /dev/null
    for key in ${ssh_priv_key[@]}; do
        /usr/bin/ssh-add $key;
    done
}

# {{{ Most used Commands
mostused() {
	sed -n 's/^\([a-z]*\) .*/\1/p' $HISTFILE |
	sort |
	uniq -c |
	sort -n -k1 |
	tail -25 |
	tac
} # }}}

# {{{ ARK Extraction
extract() {
    case $1 in
        e)
            case $2 in
                *.tar.bz2)   tar xvjf $2      ;;
                *.tar.gz)    tar xvzf $2      ;;
                *.bz2)       bunzip2 $2       ;;
                *.rar)       unrar x $2       ;;
                *.gz)        gunzip $2        ;;
                *.tar)       tar xvf $2       ;;
                *.tbz2)      tar xvjf $2      ;;
                *.tgz)       tar xvzf $2      ;;
                *.zip)       unzip $2         ;;
                *.Z)         uncompress $2    ;;
                *.7z)        7z x $2          ;;
                *)           echo "'$2' Cannot be extracted with $0" ;;
            esac ;;

        c)
            case $2 in
                *.tar.*)    arch=$2; shift 2;
                            tar cvf ${arch%.*} $@
                            case $arch in
                                *.gz)   gzip -9r ${arch%.*}   ;;
                                *.bz2)  bzip2 -9zv ${arch%.*} ;;
                            esac                                ;;
                *.rar)      shift; rar a -m5 -r $@; rar k $1    ;;
                *.zip)      shift; zip -9r $@                   ;;
                *.7z)       shift; 7z a -mx9 $@                 ;;
                *)          echo "Unknown archive type"      ;;
            esac ;;
            *)
                    echo "WATT?" ;;
    esac
}
# }}}

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
}# }}}

# {{{ Nato alphabet
nato() {
  cat << EOF

A - Alpha
B - Beta
C - Charlie
D - Delta
E - Echo
F - Foxtrot
G - Golf
H - Hotel
I - India
J - Juliet
K - Kilo
L - Lima
M - Mike
N - November
O - Oscar
P - Papa
Q - Quebec
R - Romeo
S - Sierra
T - Tango
U - Uniform
V - Victor
W - Whiskey
X - Xray
Y - Yankee
Z - Zulu
- - Dash
EOF
}
# }}}


# {{{ Password (re)Generator
repass() {
printf "Enter your password:\n"
printf "%s\xFE" $(read -se) | base64
}
# }}}

# {{{ Weather
login_weather() {

curl -s google.com > /dev/null
NetConn="$?"
dTime=$(date +"%d%H%M%S")
lForecast=$(find $HOME/tmp/ -name "fcast*" -mtime 0 2>/dev/null)
lForecastDate=$(basename "$lForecast" | cut -c6-13)

if [ $NetConn -lt 1 ]; then
    if [ ! -z $lForecast ]; then
        printf "Last known forcast: %s\n" $lForecastDate
        cat $lForecast
    else
        curl -s "wttr.in/Nieuwegein?lang=en" | head -7 > $HOME/tmp/fcast$dTime
        cat $lForecast
    fi
else
    printf "Last known forcast: %s\n" $lForecastDate
    cat $lForecast
fi

}
#}}}
#

# {{{ Conversion
convert() {
  from=$1
  to=$2

  case $to in
    cm)  export to=2.54;;
    inch) export to=0.39;;
  esac

  echo "$from * $to" | bc
}
