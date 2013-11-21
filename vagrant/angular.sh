#!/usr/bin/env bash

# Install Required Packages
apt-get update
apt-get install -y vim
apt-get install -y tmux
apt-get install -y git
apt-get install -y subversion
apt-get install -y fontconfig
apt-get install -y curl
apt-get install -y libcurl3 libcurl3-gnutls libcurl4-openssl-dev

# Set up Vim and Tmux
if ! type "tmux" > /dev/null; then
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
fi

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

# Install NodeJS, NPM and Grunt
if ! type "node" > /dev/null; then
    export SRC="/usr/local/src"
    cd $SRC
    wget http://nodejs.org/dist/v0.10.22/node-v0.10.22-linux-x86.tar.gz -O node.tar.gz
    tar -xvf node.tar.gz && mv node-v0.10.22-linux-x86 nodejs
    rm -Rf $SRC/node.tar.gz
    ln -sf $SRC/nodejs/bin/node /usr/local/bin/node
    ln -sf $SRC/nodejs/bin/npm /usr/local/bin/npm
    npm install -g grunt-cli
fi

# Install RVM
if ! type "rvm" > /dev/null; then
    \curl -L https://get.rvm.io | bash -s stable
    source /usr/local/rvm/scripts/rvm
    rvm requirements
    rvm install 1.9.3
    rvm use 1.9.3 --default
fi
rvm use 1.9.3 --default