#!/usr/bin/env bash

# Install
apt-get update
apt-get install -y vim
apt-get install -y tmux
apt-get install -y git
apt-get install fontconfig

# Configuration
export HOME="/home/vagrant"
rm -Rf $HOME/dotfiles
cd $HOME

# Set up dotfiles
git clone https://github.com/rudylee/dotfiles $HOME/dotfiles
git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
ln -sf $HOME/dotfiles/vimrc $HOME/.vimrc
ln -sf $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
vim +BundleInstall +qall

# Install PhantomJS and CasperJS
export SRC="/usr/local/src"
rm -Rf $SRC/phantomjs
cd $SRC
wget https://phantomjs.googlecode.com/files/phantomjs-1.9.1-linux-i686.tar.bz2
tar -xvf phantomjs-1.9.1-linux-i686.tar.bz2
mv phantomjs-1.9.1-linux-i686 phantomjs
ln -sf $SRC/phantomjs/bin/phantomjs /usr/local/bin/phantomjs

git clone git://github.com/n1k0/casperjs.git
ln -sf $SRC/casperjs/bin/casperjs /usr/local/bin/casperjs
