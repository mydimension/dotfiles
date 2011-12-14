[ !$_LOADED ] && source ~/.zshenv

ulimit -S -c 0

autoload -U is-at-least

# vi keybindings
setopt\
    auto_pushd\
    pushd_ignore_dups\
    pushd_minus\
    pushd_silent\
    pushd_to_home\
    complete_in_word\
    list_packed\
    append_history\
    share_history\
    hist_find_no_dups\
    hist_ignore_all_dups\
    correct\
    short_loops\
    monitor\
    check_jobs\
    long_list_jobs\
    prompt_bang\
    prompt_percent\
    prompt_subst

# this option added in 4.3.9
is-at-least 4.3.9 && setopt hist_fcntl_lock

unset\
    bg_nice\
    auto_param_slash

[ -f ~/.aliasrc ] && source ~/.aliasrc

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

zmodload zsh/complist
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

autoload -U compinit && compinit
autoload colors zsh/terminfo
autoload -U add-zsh-hook
autoload -U vcs_info
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
elif [[ "$termcap[colors]" -ge 8 ]]; then
    colors
fi
PR_RED="%{$fg[red]%}"
PR_GREEN="%{$fg[green]%}"
PR_YELLOW="%{$fg[yellow]%}"
PR_BLUE="%{$fg[blue]%}"
PR_MAGENTA="%{$fg[magenta]%}"
PR_CYAN="%{$fg[cyan]%}"
PR_WHITE="%{$fg[white]%}"
PR_LIGHT_RED="%B$PR_RED"
PR_LIGHT_GREEN="%B$PR_GREEN"
PR_LIGHT_YELLOW="%B$PR_YELLOW"
PR_LIGHT_BLUE="%B$PR_BLUE"
PR_LIGHT_MAGENTA="%B$PR_MAGENTA"
PR_LIGHT_CYAN="%B$PR_CYAN"
PR_LIGHT_WHITE="%B$PR_WHITE"
#for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
#    eval PR_$color='%{$fg[${(L)color}]%}'
#    eval PR_LIGHT_$color='%B%{$fg[${(L)color}]%}'
#    (( count = $count + 1 ))
#done
PR_NO_COLOR="%{$terminfo[sgr0]%}"

autoload -U compinit
compinit
bindkey '^r' history-incremental-search-backward
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache/$HOST
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:processes' command 'ps -axw'
zstyle ':completion:*:processes-names' command 'ps -awxho command'

# Completion Styles
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# list of completers to use
zstyle ':completion:*' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
local _myhosts
if [[ -f $HOME/.ssh/known_hosts ]]; then
    _myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
fi
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}') $_myhosts

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' stagedstr     "|$PR_GREEN+$PR_MAGENTA"
zstyle ':vcs_info:*' unstagedstr   "|$PR_RED*$PR_MAGENTA"
zstyle ':vcs_info:*' actionformats "$PR_MAGENTA%{%}[$PR_GREEN%b$PR_MAGENTA|$PR_RED%a$PR_MAGENTA]$PR_NO_COLOR"
if is-at-least 4.3.11; then
    zstyle ':vcs_info:*' formats "$PR_MAGENTA%{%}[$PR_GREEN%b$PR_MAGENTA%c%u]$PR_COLOR"
else
    zstyle ':vcs_info:*' formats "$PR_MAGENTA%{%}[$PR_GREEN%b$PR_MAGENTA]$PR_COLOR"
fi

# run before each prompt re-paint
precmd () {
    # change terminal title
    case $TERM in
        (xterm*|rxvt*) echo -ne "\033]0; $USER@${HOSTNAME%%.*}:${PWD/$HOME/~}\007" ;;
        (screen*)     echo -ne "\033k $USER@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"  ;;
    esac

    # update VCS information in prompt
    vcs_info
}

export PS1="$PR_YELLOW<%j> %(!.$PR_RED.$PR_GREEN)%n$PR_LIGHT_WHITE@%b$PR_BLUE%m$PR_LIGHT_CYAN:%5~%b \${vcs_info_msg_0_}%b %(!.$PR_RED#.$PR_GREEN$)$PR_NO_COLOR "
export RPS1="%1v $PR_LIGHT_RED%D{%H:%M:%S %m/%d}$PR_NO_COLOR"

export SPROMPT='zsh: correct '\''%R'\'' to '\''%r'\'' [(n)o (y)es (a)bort (e)dit]? '

autoload -U zrecompile
[ -f $ZDOTDIR/.zshrc ]             && zrecompile -q -p $ZDOTDIR/.zshrc
[ -f $ZDOTDIR/.zcompdump ]         && zrecompile -q -p $ZDOTDIR/.zcompdump
[ -f $ZDOTDIR/.zshrc.zwc.old ]     && rm -f $ZDOTDIR/.zshrc.zwc.old
[ -f $ZDOTDIR/.zcompdump.zwc.old ] && rm -f $ZDOTDIR/.zcompdump.zwc.old
