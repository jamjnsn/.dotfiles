#!/bin/zsh
# ==================================================

source zsh/zshenv

# ==================================================
# zsh
# ==================================================

mkdir -p $ZDOTDIR;

ln -s $DOTFILES/zsh/zshenv $HOME/.zshenv
ln -s $DOTFILES/zsh/zshrc $ZDOTDIR/.zshrc

# ==================================================
# alacritty
# ==================================================

mkdir -p $XDG_CONFIG_HOME/alacritty
ln -s "$DOTFILES/alacritty/alacritty.yml" "$XDG_CONFIG_HOME/alacritty/alacritty.yml"

# ==================================================
# tmux
# ==================================================

mkdir -p $XDG_CONFIG_HOME/tmux
ln -s "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"

# ==================================================
# nano
# ==================================================

ln -s "$DOTFILES/nano/nanorc" "$HOME/.nanorc"

# ==================================================
# Git
# ==================================================

git config --global user.name "Jamie Jansen"
git config --global user.email "jamie@jnsn.me"