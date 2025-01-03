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

[ -x "$(command -v zoxide)" ] && eval "$(zoxide init zsh)"
[ -x "$(command -v mcfly)" ] && eval "$(mcfly init zsh)"
[ -x "$(command -v navi)" ] && eval "$(navi widget zsh)"
[ -x "$(command -v fnm)" ] && eval "$(fnm env --use-on-cd)"

autoload -Uz add-zsh-hook

autoload -Uz compinit
compinit

# Installed via Pacman
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

append_fpath $ZDOTDIR/completions

# fnm
if [ -x "$(command -v fnm)" ]; then
    export PATH="/home/jamie/.local/share/fnm:$PATH"
    eval "`fnm env`"
fi

# ==================================================
# Load aliases & functions
# ==================================================

source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh
source $ZDOTDIR/keybindings.zsh

# ==================================================
# Autostart tmux in kitty
# ==================================================

if [ -z "$TMUX" ] && [ "$TERM" = "xterm-kitty" ]; then
  tmux attach || exec tmux new-session && exit;
fi

# ==================================================
# Prompt
# ==================================================

append_fpath $ZDOTDIR/prompt
autoload -Uz prompt && prompt
