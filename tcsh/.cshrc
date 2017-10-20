# $FreeBSD: head/share/skel/dot.cshrc 278616 2015-02-12 05:35:00Z cperciva $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
# more examples available at /usr/share/examples/csh/
#
# Reload cshrc
alias usrrld	source $HOME/.cshrc

# Basics
alias h		history 25
alias j		jobs -l
alias la	ls -aF
alias lf	ls -FA
alias ll	ls -lAF
alias ls	ls -G
alias c		clear

# Sudo crap
alias s		sudo
alias S		sudo su
alias ss	sudo su -


# Editor
alias vi	nvim
alias cd	pushd

# Ports
alias p		'cd /usr/ports && cd'

# Sadis

# These are normally set through /etc/login.conf.  You may override them here
# if wanted.
# set path = (/sbin /bin /usr/sbin /usr/bin /usr/local/sbin /usr/local/bin $HOME/bin)
# setenv	BLOCKSIZE	K
# A righteous umask
# umask 22

setenv	EDITOR	vi
setenv	PAGER	more

## WB: startx if it isn't already running
#set XPID = `/usr/bin/pgrep xinit`
#if ( { [ -n "$XPID" ] } ) then
  #  #echo "X is already running"
  #else
  #startx
  #logout
  #endif


if ($?prompt) then
	# An interactive shell -- set some stuff up
	#	set prompt = "%N@%m:%~ %# "
	set prompt="%{\e[0;33m%}%n%{\e[0m%}@%{\e[34m%}%m:%{\e[31m%}%l %{\e[37m%}%~%{\e[31m%} \n%#%{\e[0m%} "
	set promptchars = "%#"

	set filec
	set history = (2000 "%h %D.%W %T %R\n")
	set savehist = (2000 merge)
	set histfile = "$HOME/.history"
	set histdup = erase
	set autolist = ambiguous
	# Use history to aid expansion
	set autoexpand
	set autorehash = always
	set autocorrect
	set mail = (/var/mail/$USER)
	set implicitcd
	set complete = enhance
	set pushdsilent
	set pushdtohome
	
	set hostlist = (`cat $HOME/.ssh/config | awk '/Host / {print $2}'`)
	complete ssh 'p/1/$hostlist/' 'p/2/c/'
	if ( $?tcsh ) then
		bindkey "^W" backward-delete-word
		bindkey -k up history-search-backward
		bindkey -k down history-search-forward
	endif
	alias postcmd 'history -S'
endif

