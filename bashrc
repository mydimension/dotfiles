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

[ -f ~/.prompt ] && . ~/.prompt

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

# this overrides the in-built function to strip control characters
__git_list_all_commands ()
{
	local i IFS=" "$'\n'
	for i in $(git help -a|egrep --color=never '^  [a-zA-Z0-9]')
	do
		case $i in
		*--*)             : helper pattern;;
		*) echo $i;;
		esac
	done
}

shopt -s extglob
set +o nounset

# these control the behavior of __git_ps1
export GIT_PS1_SHOWDIRTYSTATE=1
#export GIT_PS1_SHOWSTASHSTATE=1
#export GIT_PS1_SHOWUNTRACKEDFILES=1
#export GIT_PS1_SHOWUPSTREAM="auto"

set_prompt
