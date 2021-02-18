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
set cursorline!
setlocal autoindent
setlocal cindent
setlocal smartindent

" Disable syntax higlighting after 128 columns
set synmaxcol=128
syntax sync minlines=256

" Plugins
call plug#begin('~/.vim/plugged')

" Tools
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'Shougo/denite.nvim'
Plug 'raghur/fruzzy'
Plug 'tomtom/tcomment_vim'
Plug 'mileszs/ack.vim'
Plug 'benmills/vimux'

" Github tool
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

" HTML
Plug 'othree/html5.vim'

" Colorscheme and UI
Plug 'morhetz/gruvbox'

" Javascript and React
Plug 'neoclide/vim-jsx-improve'
Plug 'jason0x43/vim-js-indent'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Node
Plug 'moll/vim-node'

" Go
Plug 'fatih/vim-go'

" CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" CoffeeScript
Plug 'kchmck/vim-coffee-script'
Plug 'nikvdp/ejs-syntax'

" TypeScript
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }

" GraphQL
Plug 'jparise/vim-graphql'

Plug 'rudylee/nvim-gist'

" Autocomplete
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#end()

if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme gruvbox
let g:gruvbox_contrast_dark = "medium"
highlight Comment cterm=italic gui=italic

" Set up leader key to <,>
let mapleader = ","

" Hide bookmarks and help text
let g:NERDTreeMinimalUI = 1

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
imap <C-q> <ESC>:bd #<cr>

" Create new buffer
nnoremap <leader>B :enew<cr>

" Close all buffers
nnoremap <leader>ba :bufdo bd!<cr>

" Map semicolon to colon
map ; :

" Key mapping for tab
map <C-t> <esc>:tabnew<CR>

" Key mapping for window management
map <C-x> <C-w>c
map <Leader>w <C-w>w

" Edit Vimrc
command! Vimrc :vs $MYVIMRC

" Enable jsx syntax
let g:jsx_ext_required = 0

" Highlight ruby code when the line is more than 80 characters
augroup vimrc_autocmds
  autocmd BufEnter *.rb highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  autocmd BufEnter *.rb match OverLength /\%81v.\+/
augroup END

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Prettify JSON
nnoremap <leader>pp :%!python -m json.tool<cr>

" Enable 256 color support in tmux <http://superuser.com/questions/399296/256-color-support-for-vim-background-in-tmux>
set t_ut=

" Copy to clipboard
noremap <Leader>y "*y

" Gist
let g:gist_post_private = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimux
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run current test file inside tmux pane
nnoremap <leader>r :call VimuxRunCommand("bundle exec rspec " . bufname("%"))<CR>
nnoremap <leader>rf :call VimuxRunCommand("bundle exec rspec " . bufname("%") . " --tag focus")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeDirArrows=0
let NERDTreeChDirMode=2
let NERDTreeShowLineNumbers=1

nmap <leader>ne :NERDTree<cr>
nmap <leader>n :NERDTreeFind<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

let g:coc_global_extensions = ['coc-solargraph']

nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Denite
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction

call denite#custom#option('_', {
     \ 'prompt': '❯',
     \ 'winheight': 15,
     \ 'updatetime': 1,
     \ 'auto_resize': 0,
     \ 'highlight_matched_char': 'Underlined',
     \ 'highlight_mode_normal': 'CursorLine',
     \ 'auto-accel': 1,
     \ 'start_filter': 1,
     \ 'vertical_preview': 1,
     \})

call denite#custom#source('file/rec', 'vars', {
     \'command': ['rg', '--files', '--glob', '!.git'],
     \'matchers': ['matcher/fruzzy'],
     \'sorters':['sorter_sublime'],
     \})

call denite#custom#source('grep', 'vars', {
     \'command': ['rg'],
     \'default_opts': ['-i', '--vimgrep'],
     \'recursive_opts': [],
     \'pattern_opt': [],
     \'separator': ['--'],
     \'final_opts': [],
     \'matchers': ['matcher/ignore_globs', 'matcher/regexp', 'matcher/pyfuzzy']
     \})

nnoremap <C-p> :<C-u>Denite file/rec<CR>
nnoremap <leader>s :<C-u>Denite buffer<CR>

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <Tab>   denite#do_map('choose_action')
  nnoremap <silent><buffer><expr> <ESC>   denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select')
  nnoremap <silent><buffer><expr> i       denite#do_map('open_filter_buffer')
endfunction

autocmd FileType denite-filter call s:denite_filter_settings()
function s:denite_filter_settings() abort
  setl nonumber

  inoremap <silent><buffer><expr>   <ESC> denite#do_map('quit')
  inoremap <silent><buffer> <CR>    <ESC><C-w>p:call denite#call_map('do_action')<CR>
  inoremap <silent><buffer> <C-s>   <ESC><C-w>p:call denite#call_map('do_action', 'vsplit')<CR>
  inoremap <silent><buffer> <C-v>   <ESC><C-w>p:call denite#call_map('do_action', 'split')<CR>
  inoremap <silent><buffer> <C-t>   <ESC><C-w>p:call denite#call_map('do_action', 'tabopen')<CR>
  inoremap <silent><buffer> <C-d>   <ESC><C-w>p:call denite#call_map('do_action', 'delete')<CR><C-w>pA
  inoremap <silent><buffer> <Tab>   <Esc><C-w>p:call denite#call_map('choose_action')<CR>
  inoremap <silent><buffer> <Space> <Esc><C-w>p:call denite#call_map('toggle_select')<CR><C-w>pA
  inoremap <silent><buffer> <C-j>   <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
  inoremap <silent><buffer> <C-k>   <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ack
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('rg')
  " Use rg over grep
  set grepprg=rg\ --nogroup\ --nocolor

  let g:ackprg = 'rg --vimgrep'
endif

" bind K to grep word under cursor
nnoremap K :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ack<SPACE>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" run goimports on save
let g:go_fmt_command = "goimports"

" Speed up syntax highlighting
" https://vim.fandom.com/wiki/Speed_up_Syntax_Highlighting
augroup vimrc
  autocmd!
  autocmd BufWinEnter,Syntax * syn sync minlines=500 maxlines=500
augroup END
