set nocompatible
set nu
set nobackup
set nowritebackup
set noswapfile
set hlsearch
set ruler
set laststatus=2
set tabstop=2
set shiftwidth=2
set expandtab

" Disable Arrows Keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Map CTRL+S to save file
map <C-s> :w<cr>
imap <C-s> <ESC>:w<cr>a

" Plugins
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'

filetype plugin indent on

" Set color to molokai and set 256 color
colors molokai
set t_Co=256
set term=screen-256color

