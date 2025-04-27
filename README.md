# Dotfiles

My personal development tools config.

### Install Homebrew

[Official Website](https://brew.sh/)

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install zsh and oh-my-zsh

Before copying all configs, you need to install `zsh` and `oh-my-zsh`. Check out the official website on how to install them [https://ohmyz.sh/](https://ohmyz.sh/)

### Install development tools

```bash
brew update
brew install neovim --HEAD
brew install tmux
brew install ripgrep
brew install rbenv
brew install pyenv
```

### Install NVM

Check [NVM](https://github.com/nvm-sh/nvm) official repository on how to install NVM.

NVM Homebrew is not supported so it is recommended to use the installation script.


### Download and Install JetBrains Mono Patched Fonts

1. Go to [nerd-fonts release page](https://github.com/ryanoasis/nerd-fonts/releases)
2. Find the the latest release of JetBrainsMono, download and install.

### Install powerlevel10k zsh theme

[powerlevel10k](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh)

```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### Create symbolic links for all config files

```bash
mkdir ~/.config
mkdir ~/.config/nvim

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
