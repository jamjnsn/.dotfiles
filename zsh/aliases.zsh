#!/usr/bin/env zsh

# ==================================================
# 	App replacements
# ==================================================

# Use exa instead of ls
if command -v exa &> /dev/null; then 
    alias ls="exa --group-directories-first --all --icons --classify"
else
    # Add pretty colors if exa isn't available
    alias ls="ls --color=auto"
fi

# ls shortcuts
alias ll="ls -la"

# Use zoxide instead of cd
[ -x "$(command -v zoxide)" ] && alias cd="z"

# ==================================================
# 	zsh directory history
# ==================================================

alias d="dirs -v"
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# ==================================================
# 	Add default flags
# ==================================================

alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"
alias wget='wget -c --hsts-file="$XDG_DATA_HOME/wget-hsts"' # Resume unfinished download

# Add colors
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias df="df -h"
alias du="du -h"
alias free="free -h"
alias diff="diff --color"
alias ip="ip -color"

# Use grc if present
if (( $+commands[grc] )); then
	alias dig="grc \dig"
	alias netstat="grc \netstat"
	alias ping="grc \ping"
	alias tail="grc \tail"
fi

# Replace dig
[ -x "$(command -v dog)" ] && alias dig="dog"

# ==================================================
# 	Laravel
# ==================================================

alias sail="bash vendor/bin/sail"
alias artisan="php artisan"

# ==================================================
# 	ADB
# ==================================================

# Use alternate data path
alias adb='HOME="$XDG_DATA_HOME"/android adb'

# Remove package by name
alias adbrmv="adb shell pm uninstall --user 0"

# ==================================================
# 	Docker
# ==================================================

alias dc="docker compose"
alias dcupdate="dc pull && dc up -d"

# ==================================================
# 	pacman
# ==================================================

alias pacman="sudo pacman"

# ==================================================
# 	WSL
# ==================================================

alias winget="powershell.exe -Command winget"

# ==================================================
# 	Everything else
# ==================================================

# pueue
alias q="pueue"
alias qq="pueue add --"

# Use cargo-update to update all crates
alias cargo-update="cargo install-update -a"

# Switch to root terminal
alias root="sudo -i"

# Quickly download via yt-dlp
alias ytdld="yt-dlp -P ~/Downloads"

# Update Grub config
alias update-grub="sudo grub-mkconfig -o /boot/grub/gub.cfg"

# Shortcut to interact with virt-manager using virsh
alias vman="virsh --connect qemu:///system"

# AUR helper aliases
alias yay="yay"
alias nay="yay -Rns"
