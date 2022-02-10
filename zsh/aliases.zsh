#!/usr/bin/env zsh

# ==================================================
# App replacements
# ==================================================

if command -v exa &> /dev/null; then 
    alias ls='exa --group-directories-first --all --icons --classify'
else
    # Add pretty colors if exa isn't available
    alias ls='ls --color=auto'
fi

if command -v zoxide &> /dev/null; then alias cd="z"; fi        # zoxide
if command -v batcat &> /dev/null; then alias cat="batcat"; fi  # batcat

# ==================================================
# zsh directory history
# ==================================================

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# ==================================================
# Add default flags
# ==================================================

alias rm='rm --one-file-system -I'
alias mv='mv -iv'
alias cp='cp -riv'
alias mkdir='mkdir -vp'
alias wget="wget -c"                # Resume unfinished download

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ==================================================
# WSL shortcuts
# ==================================================

alias cmd='cmd.exe'
alias explore='explorer.exe .'

alias pwsh="/mnt/c/Program\ Files/PowerShell/7/pwsh.exe"
alias supwsh="powershell.exe Start-Process -Verb runas -FilePath wsl"
alias winget="pwsh -Command winget"

# ==================================================
# Laravel
# ==================================================

alias sail='bash vendor/bin/sail'
alias artisan='php artisan'

# ==================================================
# trash-cli
# ==================================================

if command -v trash-put &> /dev/null; then
	alias trash='trash-put'
	alias untrash='trash-restore'
	alias lstrash='trash-list'
	alias mttrash='trash-empty'
fi

# ==================================================
# ADB
# ==================================================

# Remove package by name
alias adbrmv='adb shell pm uninstall --user 0'

# ==================================================
# Docker
# ==================================================

alias dc="docker-compose"
alias dcupdate="dc pull && dc up -d"

# ==================================================
# Everything else
# ==================================================

alias root="sudo -i"
alias reload='exec zsh'

alias npmr='npm run'
alias apt='sudo apt'                # Never forget the sudo again

alias dossh="doctl compute ssh"		# DigitalOcean SSH

alias ytdld="yt-dlp -P ~/Downloads"