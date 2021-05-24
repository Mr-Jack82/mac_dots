source "$HOME/.cargo/env"

# bat as pager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PAGER="bat --paging=always"
