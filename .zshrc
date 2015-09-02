[ !$_LOADED ] && source ~/.zshenv

# do not produce coredumps
ulimit -S -c 0

# need this for version scoping
autoload -U is-at-least

## cd management
setopt auto_pushd           # auto push onto directory stack
setopt pushd_ignore_dups    # ...except for duplicates
setopt pushd_minus          # more human use of cd +/-
setopt pushd_silent         # just silently push
setopt pushd_to_home        # 'pushd' goes to $HOME
## completion
setopt complete_in_word     # allow completion inside a string
setopt list_packed          # tighter list view
unset  auto_param_slash     # don't put the directory slash on immediately
## history
setopt append_history       # each session appends history instead of overriting
setopt share_history        # multiple sessions share history session file
setopt hist_find_no_dups    # de-dup history searches
setopt hist_ignore_all_dups # de-dup all history entries
is-at-least 4.3.9 && setopt hist_fcntl_lock  # prevent OS locking when saving history
## Input/Output
setopt correct              # do command correction
setopt short_loops          # short forms on control structs
## job control
setopt monitor              # turn on
setopt check_jobs           # interrupt leaving a session with background jobs
setopt long_list_jobs       # be verbose
unset  bg_nice              # background jobs are people too
## prompting
setopt prompt_bang          # '!' is special
setopt prompt_percent       # '%' is special
setopt prompt_subst         # live parameter substitution

# my aliases
[ -f ~/.aliasrc ] && source ~/.aliasrc

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

zmodload zsh/complist              # stylin completion

autoload -U compinit && compinit   # initialize completion system
autoload colors zsh/terminfo       # color arrays
autoload -U add-zsh-hook           # event hook system
autoload -U url-quote-magic        # dynamic escaping of url characters
    zle -N self-insert url-quote-magic

# bring in the pretty colors
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
elif [[ "$termcap[colors]" -ge 8 ]]; then
    colors
fi

# handy keybindings
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
zstyle ':completion:*' menu select
zstyle ':completion:*' cache-path ~/.zsh/cache/$HOST
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:processes-names' command 'ps -awxho command'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# list of completers to use
zstyle ':completion:*' completer _expand _complete _ignored _approximate

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# use /etc/hosts and known_hosts for hostname completion
[ -r /etc/ssh/ssh_known_hosts ] &&\
    _global_ssh_hosts=(${${${${(f)"$(</etc/ssh/ssh_known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r ~/.ssh/known_hosts ] &&\
    _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r /etc/hosts ] &&\
    : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
    "$_global_ssh_hosts[@]"
    "$_ssh_hosts[@]"
    "$_etc_hosts[@]"
    "$HOST"
    localhost
)
zstyle ':completion:*:hosts' hosts $hosts

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

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
    dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
    hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
    mailman mailnull mldonkey mysql nagios \
    named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
    operator pcap postfix postgres privoxy pulse pvm quagga radvd \
    rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'
# ... unless we really want to.
zstyle '*' single-ignored show

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

# run before each prompt re-paint
title_precmd() {
    # change terminal title
    case $TERM in
        (xterm*|rxvt*) echo -ne "\033]0; $USER@${HOSTNAME%%.*}:${PWD/$HOME/~}\007" ;;
        (screen*)      echo -ne "\033k $USER@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\" ;;
    esac
}

function precmd () {
    title_precmd
}

## setup vi mode
function zle-line-init zle-keymap-select {
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

#changing mode clobbers the keybinds, so store the keybinds before and execute them after
binds=`bindkey -L`
bindkey -v
for bind in ${(@f)binds}; do eval $bind; done
unset binds

source $HOME/dotfiles/promptline.sh

export SPROMPT='zsh: correct '\''%R'\'' to '\''%r'\'' [(n)o (y)es (a)bort (e)dit]? '

if [[ -x /opt/local/Library/Frameworks/Python.framework/Versions/Current/bin/virtualenvwrapper.sh ]]; then
    source /opt/local/Library/Frameworks/Python.framework/Versions/Current/bin/virtualenvwrapper.sh
fi

source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# recompile cache files
autoload -U zrecompile
[ -f $ZDOTDIR/.zshrc ]             && zrecompile -q -p $ZDOTDIR/.zshrc
[ -f $ZDOTDIR/.zcompdump ]         && zrecompile -q -p $ZDOTDIR/.zcompdump
[ -f $ZDOTDIR/.zshrc.zwc.old ]     && rm -f $ZDOTDIR/.zshrc.zwc.old
[ -f $ZDOTDIR/.zcompdump.zwc.old ] && rm -f $ZDOTDIR/.zcompdump.zwc.old
