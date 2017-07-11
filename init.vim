set encoding=utf8
set nocompatible
set nu
set nobackup
set nocursorline
set nocursorcolumn
set nowritebackup
set noswapfile
set hlsearch
set ruler
set laststatus=2
set tabstop=2
set shiftwidth=2
set scrolljump=5
set expandtab
set hidden
set lazyredraw
set ttyfast
set re=1

" Plugins
call plug#begin('~/.vim/plugged')

" Tools
Plug 'ryanoasis/vim-devicons'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'd11wtq/ctrlp_bdelete.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'mattn/emmet-vim'
Plug 'tomtom/tcomment_vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'gregsexton/MatchTag'
Plug 'mileszs/ack.vim'
Plug 'benmills/vimux'

" Colorscheme and UI
Plug 'morhetz/gruvbox'

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

" Coffeescript
Plug 'kchmck/vim-coffee-script'

" Autocomplete
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'carlitux/deoplete-ternjs'
Plug 'ervandew/supertab'
Plug 'neomake/neomake'

call plug#end()

" Enable deoplete
let g:deoplete#enable_at_startup = 1
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0  " This do disable full signature type on autocomplete
set completeopt-=preview

set background=dark
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

" Use jj as ESC
:imap jj <Esc>

" Key mapping for tab
map <C-t> <esc>:tabnew<CR>

" Key mapping for window management
map <C-x> <C-w>c
map <Leader>w <C-w>w

" Enable jsx syntax
let g:jsx_ext_required = 0

" CtrlP Configuration
let g:ctrlp_working_path_mode = 'a'
call ctrlp_bdelete#init()

" NERDTree configuration
let g:NERDTreeDirArrows=0
let NERDTreeChDirMode=2
let NERDTreeShowLineNumbers=1

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

" Run current test file inside tmux pane
if &ft=='ruby'
  nnoremap <leader>r :VimuxRunCommand "bundle exec rspec ".@%<cr>
endif

" Enable 256 color support in tmux <http://superuser.com/questions/399296/256-color-support-for-vim-background-in-tmux>
set t_ut=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The Silver Searcher <http://robots.thoughtbot.com/faster-grepping-in-vim>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ackprg = 'ag --vimgrep'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ack<SPACE>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linting <https://github.com/mhartington/dotfiles/blob/master/vimrc>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! neomake#makers#ft#javascript#eslint()
    return {
        \ 'args': ['-f', 'compact'],
        \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
        \ '%W%f: line %l\, col %c\, Warning - %m'
        \ }
endfunction

let g:neomake_javascript_enabled_makers = ['eslint']

autocmd! BufWritePost * Neomake
