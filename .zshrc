ulimit -S -c 0

setopt\
    auto_pushd\
    pushd_ignore_dups\
    pushd_minus\
    pushd_silent\
    pushd_to_home\
    complete_in_word\
    append_history\
    share_history\
    hist_ignore_dups\
    correct\
    short_loops\
    check_jobs\
    long_list_jobs\
    prompt_bang\
    prompt_percent\
    prompt_subst

unset\
    bg_nice\
    auto_param_slash

[ -f ~/.aliasrc ] && source ~/.aliasrc

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

autoload colors zsh/terminfo
autoload -U add-zsh-hook
autoload -U vcs_info
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    (( count = $count + 1 ))
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"

autoload -U compinit
compinit
bindkey '^r' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

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
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}') 
# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

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
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       '%F{5}[%F{2}%b%F{5}]%f '

# run before each prompt re-paint
precmd () {
    # change terminal title
    case $TERM in
        xterm*|rxvt*)
            echo -ne "\033]0; $USER@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"
            ;;
        screen*)
            echo -ne "\033k $USER@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"
            ;;
    esac

    # update VCS information in prompt
    vcs_info
}

export PS1="$PR_YELLOW<%j> %(!.$PR_RED.$PR_GREEN)%n$PG_WHITE@$PR_BLUE%m$PR_LIGHT_CYAN:%5~%b \${vcs_info_msg_0_}%b%(!.$PR_RED#.$PR_GREEN$)$PR_NO_COLOR "
export RPS1="$PR_LIGHT_RED%D{%H:%M:%S %m/%d}$PR_NO_COLOR"
