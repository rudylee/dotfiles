# Dotfiles

My personal neovim, tmux, kitty and zsh config.

### Install zsh and oh-my-zsh

Before copying all configs, you need to install `zsh` and `oh-my-zsh`. Check out the official website on how to install them [https://ohmyz.sh/](https://ohmyz.sh/)

### Install neovim, tmux and ripgrep

```bash
brew install neovim --HEAD
brew install tmux
brew install ripgrep
```

### Create symbolic links for all config files

```bash
mkdir ~/.config
mkdir ~/.config/nvim

ln -sf ~/dotfiles/zlogin ~/.zlogin
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/githelpers ~/.githelpers
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/dotfiles/bashrc ~/.bashrc
```

### Change Mac Key Repeat

```bash
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
```
