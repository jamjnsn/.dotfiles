#!/usr/bin/env zsh
# ==================================================

# Add to fpath without duplicating entries
append_fpath () {
    case " $fpath " in
        *" $1 "*)
            ;;
        *)
            fpath=(${fpath:+$fpath} $1)
    esac
}

# ==================================================
# Navigation
# ==================================================

setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

# ==================================================
# History
# ==================================================

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

# ==================================================
# Load plugins
# ==================================================

if command -v zoxide &> /dev/null; then eval "$(zoxide init zsh)"; fi

source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

append_fpath $ZDOTDIR/plugins/zsh-completions/src
append_fpath $ZDOTDIR/completions

eval "$(fnm env --use-on-cd)"

# =================================================
# lf file selector
# =================================================

_zlf() {
    emulate -L zsh
    local d=$(mktemp -d) || return 1
    {
        mkfifo -m 600 $d/fifo || return 1
        tmux split -bf zsh -c "exec {ZLE_FIFO}>$d/fifo; export ZLE_FIFO; exec lf" || return 1
        local fd
        exec {fd}<$d/fifo
        zle -Fw $fd _zlf_handler
    } always {
        rm -rf $d
    }
}
zle -N _zlf
bindkey '\ek' _zlf

_zlf_handler() {
    emulate -L zsh
    local line
    if ! read -r line <&$1; then
        zle -F $1
        exec {1}<&-
        return 1
    fi
    eval $line
    zle -R
}
zle -N _zlf_handler

# ==================================================
# Load aliases & functions
# ==================================================

source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh

# ==================================================
# Prompt
# ==================================================

append_fpath $ZDOTDIR/prompt
autoload -Uz prompt && prompt

# ==================================================
# Local overrides
# ==================================================

if [ -f $ZDOTDIR/zshrc.local ]; then source $ZDOTDIR/zshrc.local; fi
