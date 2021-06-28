# Dotfiles

My personal neovim, tmux, alacritty and zsh config.

### Install zsh and oh-my-zsh

Before copying all configs, you need to install `zsh` and `oh-my-zsh`. Check out the official website on how to install them [https://ohmyz.sh/](https://ohmyz.sh/)

### Install neovim and tmux

```
brew install neovim --HEAD
brew install tmux
```

### Create symbolic links for all config files

```
mkdir ~/.config
mkdir ~/.config/nvim
mkdir ~/.config/alacritty

ln -sf ~/dotfiles/zlogin ~/.zlogin
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/githelpers ~/.githelpers
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -sf ~/dotfiles/bashrc ~/.bashrc
```

### Install Alacritty

##### Update terminfo

In order for Alacritty to work properly with tmux, we need to change the terminfo. Use the snippet below to update the terminfo.

```
# Clone alacritty
git clone https://github.com/alacritty/alacritty.git
cd alacritty

# setup terminfo
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

# cleanup
cd .. && rm -rf alacritty
```
