#!/bin/zsh
# ==================================================

source zsh/zshenv

# ==================================================
# zsh
# ==================================================

mkdir -p $ZDOTDIR;

ln -sf $DOTFILES/zsh/zshenv $HOME/.zshenv
ln -sf $DOTFILES/zsh/zshrc $ZDOTDIR/.zshrc

# ==================================================
# tmux
# ==================================================

mkdir -p $XDG_CONFIG_HOME/tmux;
ln -sf "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"

# ==================================================
# nano
# ==================================================

ln -sf "$DOTFILES/nano/nanorc" "$HOME/.nanorc"

# ==================================================
# Git
# ==================================================

git config --global user.name "Jamie Jansen"
git config --global user.email "jamie@jnsn.me"