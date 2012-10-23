autoload -U is-at-least

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

is-at-least 4.3.9 && setopt hist_fcntl_lock

unset\
    bg_nice\
    auto_param_slash
