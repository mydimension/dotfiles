# vim:ft=zsh
source "$ZSH/themes/agnoster.zsh-theme"

prompt_status () {
    prompt_segment black default "%(0?..%{%F{red}%}✘)%(!.%{%F{yellow}%}⚡.)%(1j.%{%F{cyan}%}⚙.)"
}

prompt_dir () {
    prompt_segment blue black '%5~'
}
