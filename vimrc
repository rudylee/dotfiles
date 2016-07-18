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
set hidden
set cursorline
set lazyredraw

" Plugins
call plug#begin('~/.vim/plugged')

" Tools
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-endwise'
Plug 'lambdalisue/vim-gita', { 'on': ['Gita'] }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'mattn/emmet-vim'
Plug 'tomtom/tcomment_vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'gregsexton/MatchTag'

" Code Completion
Plug 'Shougo/neocomplete.vim'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

" Colorscheme and UI
Plug 'morhetz/gruvbox'
Plug 'bling/vim-bufferline'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Ruby
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

" PHP
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug 'captbaritone/better-indent-support-for-php-with-html'

" Javascript and React
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' }
Plug 'mxw/vim-jsx'

call plug#end()

set background=dark
set t_Co=256
set term=xterm-256color
colorscheme gruvbox

" Set up leader key to <,>
let mapleader = ","

" Map leader+<,> to open NERDTree
nmap <leader>ne :NERDTree<cr>

" Map Keys for Managing Buffers
map <C-J> :bnext<CR>
map <C-K> :bprev<CR>
map <C-L> :tabn<CR>
map <C-H> :tabp<CR>

" Map CTRL+S to save file
map <C-s> :w<cr>
imap <C-s> <ESC>:w<cr>a

" Map CTRL+Q to close buffer
map <C-q> :bp\|bd #<cr>
imap <C-q> <ESC>:bp\|bd #<cr>

" Key mapping for Dash
:nmap <silent> <leader>d <Plug>DashSearch

" Use jj as ESC
:imap jj <Esc>

" Key mapping for tab
map <C-t> <esc>:tabnew<CR>

" Key mapping for window management
map <C-x> <C-w>c
map <Leader>w <C-w>w

" Neocomplete
let g:neocomplete#enable_at_startup = 1
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Enable jsx syntax
let g:jsx_ext_required = 0

" CtrlP Configuration
let g:ctrlp_working_path_mode = 'a'

" NERDTree configuration
let g:NERDTreeDirArrows=0
let NERDTreeChDirMode=2
let NERDTreeShowLineNumbers=1

" Airline configuration
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
let g:bufferline_echo = 0
let g:airline_theme= 'base16'
let g:airline#extensions#tabline#enabled = 1

" Highlight ruby code when the line is more than 80 characters
augroup vimrc_autocmds
  autocmd BufEnter *.rb highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  autocmd BufEnter *.rb match OverLength /\%81v.\+/

  autocmd BufEnter *.php set tabstop=4
  autocmd BufEnter *.php set shiftwidth=4
augroup END

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Prettify JSON
nnoremap <leader>pp :%!python -m json.tool<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The Silver Searcher <http://robots.thoughtbot.com/faster-grepping-in-vim>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ag<SPACE>

set t_ut=
