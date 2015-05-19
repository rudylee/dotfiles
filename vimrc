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
set lazyredraw

" Plugins
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'vim-ruby/vim-ruby'
Bundle 'mattn/emmet-vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tomtom/tcomment_vim'
Bundle 'jeffkreeftmeijer/vim-numbertoggle'
Bundle 'rizzatti/dash.vim'
Bundle 'bling/vim-bufferline'
Bundle 'bling/vim-airline'

" Snipmate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"
Bundle "garbas/vim-snipmate"

filetype off
filetype plugin indent on
syntax on

" Set color to solarized and set 256 color
let g:solarized_termcolors=16
set background=dark
set t_Co=256
set term=xterm-256color
colorscheme solarized

" Set up leader key to <,>
let mapleader = ","

" Disable Arrows Keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

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

" CtrlP Configuration
let g:ctrlp_working_path_mode = 'a'

" NERDTree configuration
let g:NERDTreeDirArrows=0
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2

" Airline configuration
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
let g:bufferline_echo = 0
let g:airline_theme= 'dark'

" Highlight the code when it's more than 80 characters
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  autocmd BufEnter * match OverLength /\%81v.\+/ 
augroup END

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test-running stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()

    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("!zeus cucumber")
      exec g:bjo_test_runner g:bjo_test_file
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("!zeus rspec")
      exec g:bjo_test_runner g:bjo_test_file
    else
      call SetTestRunner("!ruby -Itest")
      exec g:bjo_test_runner g:bjo_test_file
    endif
  else
    exec g:bjo_test_runner g:bjo_test_file
  endif
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  exec "!zeus rspec" g:bjo_test_file . ":" . g:bjo_test_file_line
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

map <leader>rt :call RunCurrentTest()<CR>
map <leader>rl :call RunCurrentLineInTest()<CR>

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
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ag<SPACE>
