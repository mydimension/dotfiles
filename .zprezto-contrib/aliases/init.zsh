# handy keybindings
bindkey '^r' history-incremental-search-backward
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line

alias jobs='jobs -l'
alias j='jobs'
alias grep='grep --color=always'
alias view='vi -R'
alias path='echo -e ${PATH//:/\\n}'
alias sshpass='ssh -o preferredauthentications=password'

if type nvim >/dev/null; then
    alias vi=nvim
else
    alias vi=vim
fi


[[ "$OSTYPE" != darwin* ]] && alias w='w -u'

[ -f /Applications/MacPorts/MacVim.app/Contents/MacOS/Vim ] &&
    alias gvim="/Applications/MacPorts/MacVim.app/Contents/MacOS/Vim -g"

alias g='gvim --remote-tab-silent'

# now just use the following in .screenrc:
#   unsetenv SSH_AUTH_SOCK
#   setenv SSH_AUTH_SOCK $HOME/.screen/ssh-auth-sock.$HOSTNAME
_ssh_auth_save() {
    [ -d "$HOME/.screen/" ] || mkdir -m 700 "$HOME/.screen/";
    if [ "$SSH_AUTH_SOCK" != "$HOME/.screen/ssh-auth-sock.$HOSTNAME" ] ; then
        ln -sf "$SSH_AUTH_SOCK" "$HOME/.screen/ssh-auth-sock.$HOSTNAME"
    fi
}
alias screen='export HOSTNAME=$(hostname) ; _ssh_auth_save ; screen'
alias tmux='export HOSTNAME=$(hostname) ; _ssh_auth_save ; tmux'

# 'ls' family
alias ls="${aliases[ls]:-ls} -v" # natural version number sorting
alias ll='ls -lh'
alias la='ll -A'
alias lx='ll -XB'
alias lk='ll -Sr'
alias lt='ll -tr'
alias lc='lt -c'
alias lu='lt -u'
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias l='la'
alias sl='ls'

alias tree='tree --dirsfirst -FCI .svn'

# hex dump a file
alias hd='od -Ax -tx1z -v'
alias realpath='readlink -f'
alias cmdstat="history | awk {'print \$2'} | sort | uniq -c | sort -k1 -rn | head"

# number base conversions
alias d2h="perl -e 'printf qq|%X\n|, int( shift )'"
alias d2o="perl -e 'printf qq|%o\n|, int( shift )'"
alias d2b="perl -e 'printf qq|%b\n|, int( shift )'"
alias h2d="perl -e 'printf qq|%d\n|, hex( shift )'"
alias h2o="perl -e 'printf qq|%o\n|, hex( shift )'"
alias h2b="perl -e 'printf qq|%b\n|, hex( shift )'"
alias o2h="perl -e 'printf qq|%X\n|, oct( shift )'"
alias o2d="perl -e 'printf qq|%d\n|, oct( shift )'"
alias o2b="perl -e 'printf qq|%b\n|, oct( shift )'"

psg ()      { ps aux | egrep "$1|%CPU" | grep -v grep; }

# Misc.
ff ()       { find . -type f -iname '*'$*'*' -ls ; }
fe ()       { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }

swap ()     { local TMPFILE="tmp.$$"; mv "$1" $TMPFILE; mv "$2" "$1"; mv $TMPFILE "$2"; }

md ()       { mkdir -p $1 && cd $1; }
lll ()      { ll $* | less; }
unixdate () { echo `perl -MHTTP::Date -e 'print @ARGV?$ARGV[0]=~/^\d+$/?scalar localtime($ARGV[0]):str2time(join " ",@ARGV):time' ${*}`; }

cssmin () {
    cat $1 | sed -e '
        s/^[ \t]*//g;       # remove leading space
        s/[ \t]*$//g;       # remove trailing space
        s/\([:{;,]\) /\1/g; # remove space after a colon, brace, semicolon, or comma
        s/ {/{/g;           # remove space before a brace
        s/\/\*.*\*\///g;    # remove comments
        /^$/d               # remove blank lines
    ' | sed -e :a -e '$!N; s/\n\(.\)/\1/; ta # remove all newlines
    ' > $2;
}

ex () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2|*.tbz2) tar xjf $1    ;;
            *.tar.gz|*.tgz)   tar xzf $1    ;;
            *.tar)            tar xf $1     ;;
            *.bz2)            bunzip2 $1    ;;
            *.rar)            rar x $1      ;;
            *.gz)             gunzip $1     ;;
            *.zip)            unzip $1      ;;
            *.Z)              uncompress $1 ;;
            *.7z)             7z x $1       ;;
            *)                echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function calc() { echo "$*" | bc; }
