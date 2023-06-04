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

### Download and Install JetBrains Mono Patched Fonts

[JetBrains Mono Bold Nerd Font Complete](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/Bold/complete/JetBrains%20Mono%20Bold%20Nerd%20Font%20Complete.ttf)
[JetBrains Mono Medium Nerd Font Complete](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/Medium/complete/JetBrains%20Mono%20Medium%20Nerd%20Font%20Complete.ttf)
[JetBrains Mono Italic Nerd Font Complete](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/Italic/complete/JetBrains%20Mono%20Italic%20Nerd%20Font%20Complete.ttf)
[JetBrains Mono Bold Italic Nerd Font Complete](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/BoldItalic/complete/JetBrains%20Mono%20Bold%20Italic%20Nerd%20Font%20Complete.ttf)

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
