#!/usr/bin/env zsh

# ==================================================
# Sticky SSH connection
# ==================================================

sssh() {
	while ! \ssh "$@"; do sleep 0.5; done
}

# ==================================================
# Create directory (full path) and cd
# ==================================================

mkcd() {
	mkdir -p $1 && cd $1
}

# ==================================================
# Launch shell for Docker container
# ==================================================

docksh() {
	docker exec -it $1 /bin/bash
}

# ==================================================
# Set permissions recursively
# ==================================================

chmodr() {
	find $1 -type d -print0 | xargs -0 chmod 0775
	find $1 -type f -print0 | xargs -0 chmod 0664
}

# ==================================================
# Nginx shortcuts
# ==================================================

ngxreload() {
	sudo service nginx reload
}

ngxedsite() {
	file=/etc/nginx/sites-available/$1
	sudo nano "$file"
	ngxreload
}

ngxensite() {
	sudo ln -sf "/etc/nginx/sites-available/$1" "/etc/nginx/sites-enabled/$1"
	ngxreload
}

ngxdissite() {
	file=/etc/nginx/sites-enabled/$1
	sudo unlink "$file"
}

ngxmksite() {
	file=/etc/nginx/sites-available/$1
	
	if [ -f "$file" ]; then
		echo "Site already exists."
	else
		sudo cp "/etc/nginx/templates/default" "$file"
		sudo nano $file
	fi
}

# ==================================================
# Reboot to the first Windows boot option found
# ==================================================

reboot2win() {
	windows_title=$(grep -i "^menuentry 'Windows" /boot/grub/grub.cfg | cut -d "'" -f 2)
	sudo grub-reboot "$windows_title" && sudo reboot
}
	
# ==================================================
# Simplified archive extraction
# ==================================================

ex() {
	# Set output directory
	if [ -z "$2" ]; then
		outdir="${1%%.*}"
	else
		outdir="$2"
	fi
	
	# Ensure output directory is valid
	if [ -f $outdir ]; then
		echo "Can't extract to \"$outdir\": file exists"
		return
	elif [ -d $outdir ]; then
		echo "Can't extract to \"$outdir\": directory exists"
		return
	fi
	
	# Attempt extraction based on filename
	if [ -f $1 ]; then
		case $1 in
			*.tar.bz2)	tar -xjf $1 -one-top-level=$outdir  ;;
			*.tar.gz)	tar xzf $1 --one-top-level=$outdir  ;;
			*.tgz)		tar xzf $1 --one-top-level=$outdir	;;
			*.zip)		unzip $1 -d $outdir				 	;;
			*.7z)		7z x $1 -o$outdir					;;
			
			*)
				echo "\"$1\" is not a supported archive"
				return
			;;
		esac
		
		echo "Extracted to 📁$outdir"
	else
		echo "\"$1\" is not a valid file"
	fi
}

# ==================================================
# Make temporary directory for the  
# duration of a subshell.
# ==================================================

tmp () {
    (
        export MY_SHLVL=tmp:$MY_SHLVL 
        export od=$PWD 
        export tmp=$(mktemp -d) 
        trap "rm -rf $tmp" 0
        cd $tmp
        if [ -z "$1" ]
        then
            $SHELL -l
        else
            [ "$1" = "-l" ] && {
                shift
                set "$@" ";" "$SHELL -l"
            }
            eval "$@"
        fi
    )
}

# ==================================================
# Reload zsh config
# ==================================================

rlzsh () {
	source $HOME/.zshenv
	source $ZDOTDIR/.zshrc
	exec /usr/bin/env zsh
}

# =================================================
# cd to last directory on lf exit
# =================================================

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# =================================================
# Quick maths
# =================================================

m() {
  python3 -c "from math import *; print($*)"
}

# =================================================
# Search packages for commands when not found
# =================================================

command_not_found_handler() {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=(
        ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"}
    )
    if (( ${#entries[@]} ))
    then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}"
        do
            # (repo package version file)
            local fields=(
                ${(0)entry}
            )
            if [[ "$pkg" != "${fields[2]}" ]]
            then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}

# =================================================
# Run PowerShell or PowerShell command
# =================================================

pwsh() {
	command=$1

	if [ -z "$command" ]; then
		powershell.exe -NoExit -Command "& {Set-Location ~}"
	else
		powershell.exe $@
	fi
}