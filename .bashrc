##
## ~/.bashrc
##

# only use .bashrc for interactive shells
if [[ $- != *i* ]]; then
	return
fi

################################################################################

export GOPATH=$HOME/Go
export PATH=$PATH:$GOPATH/bin

################################################################################

alias opaque='compton-trans -c 100'
alias trans='compton-trans -c 90'

if hash compton-trans 2> /dev/null && [[ -n "$DISPLAY" ]]; then
	compton-trans -c 90
fi

################################################################################

if hash exa 2> /dev/null; then
	alias ls='exa'
	alias ll='exa -l'
	alias la='exa -la'
else
	alias ls='ls --color=auto'
	alias ll='ls -l --color=auto'
	alias la='ls -la --color=auto'
fi

if [[ -x "~/.lock" ]]; then
	alias lock='~/.lock'
fi

alias open='xdg-open'
alias paste='xclip -sel clip -o'
alias copy='xclip -sel clip -i'

alias mote='ssh ialeinbach@mote.cs.vassar.edu'
alias me='ssh ian.leinbach@ian.leinbach.me'

alias ghci='stack ghci'
alias nenv='python3 -m venv .env'

################################################################################

get() {
	if (( $# == 0 )); then
		echo "got"
		return
	fi

	cp "$1" .
}

gitget() {
	local owner='ialeinbach'
	local repo=''

	if (( $# == 0 )); then
		echo "Please enter at least a repo name!"
		return
	fi

	case $# in
		1) owner="ialeinbach"; repo="$1" ;;
		2) owner="$1";         repo="$2" ;;
	esac

	git clone "https://github.com/$owner/$repo.git" && cd "$repo"
}

venv() {
	local env=".env/bin/activate"
	local pre="$1"

	# ensure slash between $pre and $env
	if (( $# != 0 )) && [[ "${pre:(-1)}" != "/" ]]; then
		pre+="/"
	fi

	. "$pre$env"
}

disp() {
	local connected=$(xrandr | grep " connected")

	local primary=$(echo "$connected" | grep " primary" | cut -d ' ' -f 1)
	local other=$(echo "$connected" | grep -v " primary" | cut -d ' ' -f 1)

	case $# in
		0) xargs -L 1 -I '{}' xrandr --output {} --off <<< "$other"
		   xargs -L 1 -I '{}' xrandr --output {} --auto <<< "$primary"
		;;
		1) xrandr --output "$1" --auto --same-as "$primary"
		;;
		2) xrandr --output "$1" --auto --"$2" "$primary"
		;;
	esac

	cut -d ' ' -f 1 <<< "$connected"
	~/.fehbg
}

isolate() {
	reset && clear && "$@"
}

calc() {
	bc -l <<< "$@"
}


clone() {
	$TERM -e "cd $(pwd) && $BASH" &
}

PROMPT_COMMAND=prompt_command
prompt_command() {
	local exitcode=$?

	local reset="\[\033[0m\]"
	local green="\[\033[0;32m\]"
	local red="\[\033[0;31m\]"

	PS1=""

	local venv="$VIRTUAL_ENV"
	if [[ -n "$venv" ]]; then
		PS1+="($(basename $venv)) "
	fi

	PS1+="["

	if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
		PS1+=" $(id -u -n)@$(hostname) |"
	fi

	PS1+=" \W "

	local branch="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
	if [[ -n "$branch" ]]; then
		if [[ $(git status 2> /dev/null) =~ "nothing to commit" ]]; then
			PS1+="| $green$branch$reset "
		else
			PS1+="| $red$branch$reset "
		fi
	fi

	if (( $exitcode != 0 )); then
		PS1+="]$red$ $reset"
	else
		PS1+="]$ "
	fi
}
