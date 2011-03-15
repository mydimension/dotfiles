# .bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
[ -f /etc/bashrc ]         && . /etc/bashrc

# source a local bashrc, if any
[ -f ~/.bashrc.local ] && . ~/.bashrc.local 

ulimit -S -c 0
set -o notify
#set -o noclobber # this is annoying
#set -o nounset
#set -o xtrace

shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s mailwarn
shopt -s sourcepath
shopt -s no_empty_cmd_completion  # bash>=2.04 only
shopt -s cmdhist
shopt -s histappend histreedit

shopt -u mailwarn
unset MAILCHECK

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#stty -ixon

# define some useful colors (be sure to surround with '\[' and '\]' or it borks the term)
WHITE="\[\e[1;37m\]";
GREEN="\[\e[0;32m\]";
LIGHTGREEN="\[\e[1;32m\]";
CYAN="\[\e[0;36m\]";
LIGHTCYAN="\[\e[1;36m\]";
GRAY="\[\e[0;37m\]";
RED="\[\e[0;31m\]";
LIGHTRED="\[\e[1;31m\]";
BLACK="\[\e[0;30m\]";
DARKGRAY="\[\e[1;30m\]";
BLUE="\[\e[0;34m\]";
LIGHTBLUE="\[\e[1;34m\]";
PURPLE="\[\e[0;35m\]";
LIGHTPURPLE="\[\e[1;35m\]";
BROWN="\[\e[0;33m\]";
LIGHTBROWN="\[\e[1;33m\]";
NC="\[\e[0m\]";

function function_exists {
	[ -z "$1" ] && return 1
	declare -F "$1" >/dev/null 2>&1
	return $?
}

export HISTIGNORE="&:ls:ll:lll:w"
export CDPATH=".:~"
export EDITOR=vim

# get aliases
[ -f ~/.aliasrc ] && . ~/.aliasrc

# implement directory history
[ -f ~/.dirsrc ] && . ~/.dirsrc

# set the window title
function xtitle () {
	case "$TERM" in
		*term | rxvt)
			echo -n -e "\033]0;$*\007" ;;
		*)
			;;
	esac
}

#=======================================================================
#
# PROGRAMMABLE COMPLETION - ONLY SINCE BASH-2.04
# Most are taken from the bash 2.05 documentation and from Ian McDonalds
# 'Bash completion' package
#  (http://www.caliban.org/bash/index.shtml#completion)
# You will in fact need bash-2.05a for some features
#
#=======================================================================

if [ "${BASH_VERSION%.*}" \< "2.05" ]; then
	echo "You will need to upgrade to version 2.05 for programmable completion"
	return
fi

[ -f /opt/local/etc/bash_completion ] && . /opt/local/etc/bash_completion
[ -x /etc/bash_completion           ] && /etc/bash_completion

shopt -s extglob
set +o nounset

user_color="${GREEN}"
[ "`id -u`" -eq 0 ] && user_color="${RED}"

# needs to run after bash completion is loaded
if function_exists __git_ps1; then
	PS1="${WHITE}[${user_color}\u${WHITE}@$BLUE\h${DARKGRAY}:${BROWN}\W${PURPLE}\$(__git_ps1)${WHITE}]${user_color}\\$ ${NC}"
else
	PS1="${WHITE}[${user_color}\u${WHITE}@$BLUE\h${DARKGRAY}:${BROWN}\W${WHITE}]${user_color}\\$ ${NC}"
fi
export PS1

#Escape for screen
case $TERM in
	xterm*|rxvt*)
		export PROMPT_COMMAND='history -a; echo -ne "\033]0; ${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
	;;
	screen*)
		export PROMPT_COMMAND='history -a; echo -ne "\033k ${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
	;;
esac
