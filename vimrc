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

" Plugins
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'molokai'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-ruby/vim-ruby'

" Snipmate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
Bundle "garbas/vim-snipmate"

filetype plugin indent on

" Set color to molokai and set 256 color
colors molokai
set t_Co=256
set term=screen-256color

" Disable Arrows Keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Map CTRL+S to save file
map <C-s> :w<cr>
imap <C-s> <ESC>:w<cr>a

" Map CTRL+Q to close buffer
map <C-q> :bw<cr>
imap <C-q> <ESC>:bw<cr>

