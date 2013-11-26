#!/usr/bin/env bash

# Install Required Packages
apt-get update
apt-get install -y vim
apt-get install -y tmux
apt-get install -y git
apt-get install -y subversion
apt-get install -y fontconfig
apt-get install -y curl

# Set up Vim and Tmux
export HOME="/home/vagrant"
cd $HOME
rm -Rf $HOME/dotfiles
rm -Rf $HOME/molokai
rm -Rf $HOME/.vim/colors
git clone https://github.com/rudylee/dotfiles $HOME/dotfiles
git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
git clone https://github.com/tomasr/molokai.git $HOME/molokai
ln -sf $HOME/dotfiles/vimrc $HOME/.vimrc
mkdir $HOME/.vim/ftplugin
ln -sf $HOME/dotfiles/ftplugin/php.vim $HOME/.vim/ftplugin/php.vim
ln -sf $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
mv $HOME/molokai/colors $HOME/.vim
vim +BundleInstall +qall

# Set up the bashrc
if ! grep -q "export TERM=xterm-256color" "$HOME/.bashrc"; then
    echo "export TERM=xterm-256color" >> $HOME/.bashrc
fi
if ! grep -q "stty ixany" "$HOME/.bashrc"; then
    echo "stty ixany" >> $HOME/.bashrc
fi
if ! grep -q "stty ixoff -ixon" "$HOME/.bashrc"; then
    echo "stty ixoff -ixon" >> $HOME/.bashrc
fi
if ! grep -q "stty stop undef" "$HOME/.bashrc"; then
    echo "stty stop undef" >> $HOME/.bashrc
fi
if ! grep -q "stty start undef" "$HOME/.bashrc"; then
    echo "stty start undef" >> $HOME/.bashrc
fi

# Install PHP, PHPMyAdmin and MySQL
