#!/usr/bin/env zsh

# ==================================================
# Sticky SSH connection
# ==================================================

sssh () {
	while ! ssh "$@"; do sleep 0.5; done
}

# ==================================================
# Create directory (full path) and cd
# ==================================================

mkcd () { 
  mkdir -p $1 && cd $1; 
}

# ==================================================
# Launch shell for Docker container
# ==================================================

docksh () { 
  docker exec -it $1 /bin/bash; 
}

# ==================================================
# Set permissions recursively
# ==================================================

chmodr () {
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