#!/usr/bin/env zsh
# ==================================================

export DOTFILES="$HOME/.dotfiles"

# ==================================================
# Directories
# ==================================================

# XDG base directory paths
export LOCAL_DIR="$HOME/.local"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$LOCAL_DIR/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$LOCAL_DIR/.local/state"

# Other dirs
export CONFIG="$XDG_CONFIG_HOME"

export LOCAL_SRC="$LOCAL_DIR/src"
export LOCAL_BIN="$LOCAL_DIR/bin"

# ==================================================
# Defaults
# ==================================================

export EDITOR="nano"
export VISUAL="code"
export SUDO_EDITOR="rnano"

export BROWSER="firefox"
export TERMINAL="alacritty"

export PROMPT_THEME="arch"

# ==================================================
# Software
# ==================================================

export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"

# ==================================================
# zsh
# ==================================================

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

# ==================================================
# fzf
# ==================================================

export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ==================================================
# X11
# ==================================================

export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"

# ==================================================
# NPM
# ==================================================

export NPM_PATH="$XDG_CONFIG_HOME/node_modules"
export NPM_BIN="$XDG_CONFIG_HOME/node_modules/bin"
export NPM_CONFIG_PREFIX="$XDG_CONFIG_HOME/node_modules"

# ==================================================
# Git
# ==================================================

export GIT_REVIEW_BASE=main

# ==================================================
# App directories
# ==================================================

export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="$XDG_DATA_HOME"/wine

# NPM
export NPM_PATH="$XDG_CONFIG_HOME/node_modules"
export NPM_BIN="$XDG_CONFIG_HOME/node_modules/bin"
export NPM_CONFIG_PREFIX="$XDG_CONFIG_HOME/node_modules"

# ==================================================
# PATH
# ==================================================

# Add directory to path if it isn't already there
append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

append_path $NPM_BIN
append_path $GOPATH/bin
append_path $COMPOSER_HOME/vendor/bin
append_path $CARGO_HOME/bin
append_path $LOCAL_BIN
append_path $LOCAL_BIN/scripts
append_path $DOTFILES/scripts

export PATH

# ==================================================
# Local overrides
# ==================================================
if [ -f $ZDOTDIR/zshenv.local ]; then source $ZDOTDIR/zshenv.local; fi
