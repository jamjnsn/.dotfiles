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

rlzsh () {
	source $HOME/.zshenv
	source $ZDOTDIR/.zshrc
	exec $(which zsh)
}