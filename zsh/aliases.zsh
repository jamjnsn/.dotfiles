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

# Use zoxide (z) instead of cd
if command -v zoxide &> /dev/null; then alias cd="z"; fi

# Use sticky ssh function instead of ssh
alias ssh="sssh"

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
alias wget="wget -c" # Resume unfinished download

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

# ==================================================
# 	WSL shortcuts
# ==================================================

alias cmd="cmd.exe"
alias explore="explorer.exe ."

alias pwsh="/mnt/c/Program\ Files/PowerShell/7/pwsh.exe"
alias supwsh="powershell.exe Start-Process -Verb runas -FilePath wsl"
alias winget="pwsh -Command winget"

# ==================================================
# 	Laravel
# ==================================================

alias sail="bash vendor/bin/sail"
alias artisan="php artisan"

# ==================================================
# 	ADB
# ==================================================

# Remove package by name
alias adbrmv="adb shell pm uninstall --user 0"

# ==================================================
# 	Docker
# ==================================================

alias dc="docker-compose"
alias dcupdate="dc pull && dc up -d"

# ==================================================
# 	apt
# ==================================================

alias apt="sudo apt"

# ==================================================
# 	pacman
# ==================================================

alias pacman="sudo pacman"
alias pacman-autoremove="pacman -Qdtq | pacman -Rs -" 

# ==================================================
# 	Everything else
# ==================================================

# Switch to root terminal
alias root="sudo -i"

# Quickly download via yt-dlp
alias ytdld="yt-dlp -P ~/Downloads"

# Remind myself to use rip for file deletion
if (( $+commands[rip] )); then
	alias rm="echo Use 'rip'."
fi