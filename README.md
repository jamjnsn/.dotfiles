# Install public keys
```
curl -o ~/.ssh/authorized_keys https://github.com/jamjnsn.keys
```

# Install dotfiles
```
git clone https://github.com/jamjnsn/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./dot install
git submodule update --init --recursive
```

# Install tmux plugins
- Run `tmux`
- Type `prefix + I` (capital i)
