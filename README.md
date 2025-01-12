# Dotfiles

My personal neovim, tmux, kitty and zsh config.

### Install Homebrew

[Official Website](https://brew.sh/)

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install zsh and oh-my-zsh

Before copying all configs, you need to install `zsh` and `oh-my-zsh`. Check out the official website on how to install them [https://ohmyz.sh/](https://ohmyz.sh/)

### Install neovim, tmux, ripgrep and rbenv

```bash
brew install neovim --HEAD
brew install tmux
brew install ripgrep
brew install rbenv
```

### Install NVM

[NVM](https://github.com/nvm-sh/nvm)

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

### Download and Install JetBrains Mono Patched Fonts

1. Go to `nerd-fonts` release page https://github.com/ryanoasis/nerd-fonts/releases
2. Find the the latest release of JetBrainsMono, download and install.

### Install powerlevel10k zsh theme

[How to install powerlevel10k for Oh My Zsh](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh)


### Create symbolic links for all config files

```bash
mkdir ~/.config
mkdir ~/.config/nvim

ln -sf ~/dotfiles/zlogin ~/.zlogin
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/githelpers ~/.githelpers
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/dotfiles/bashrc ~/.bashrc
```

### Change Mac Key Repeat

```bash
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
```
