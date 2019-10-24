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
Plug 'tomtom/tcomment_vim'
Plug 'mileszs/ack.vim'
Plug 'benmills/vimux'
" Plug 'ludovicchabant/vim-gutentags'

" HTML
Plug 'othree/html5.vim'

" Colorscheme and UI
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'

" Javascript and React
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'jason0x43/vim-js-indent'
Plug 'mxw/vim-jsx'

" Node
Plug 'moll/vim-node'

" Go
Plug 'fatih/vim-go'

" CoffeeScript
Plug 'kchmck/vim-coffee-script'
Plug 'nikvdp/ejs-syntax'

" TypeScript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }

let g:neomake_typescript_enabled_makers=['tslint', 'tsc']
let g:neomake_typescript_tslint_maker={
 \ 'exe': 'tslint',
 \ 'args': ['-t', 'msbuild']
 \ }

" Golden Ratio
let g:golden_ratio_exclude_nonmodifiable = 1

" Autocomplete
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'carlitux/deoplete-ternjs'
Plug 'neomake/neomake'
Plug 'benjie/neomake-local-eslint.vim'

call plug#end()

" Enable deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 500
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0  " This do disable full signature type on autocomplete
set completeopt-=preview

" set background=dark
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme OceanicNext

" Set up leader key to <,>
let mapleader = ","

" Key mapping for NERDTree
nmap <leader>ne :NERDTree<cr>
nmap <leader>n :NERDTreeFind<CR>

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

" NERDTree configuration
let g:NERDTreeDirArrows=0
let NERDTreeChDirMode=2
let NERDTreeShowLineNumbers=1

" Highlight ruby code when the line is more than 80 characters
augroup vimrc_autocmds
  autocmd BufEnter *.rb highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  autocmd BufEnter *.rb match OverLength /\%81v.\+/
augroup END

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Prettify JSON
nnoremap <leader>pp :%!python -m json.tool<cr>

" Run current test file inside tmux pane
nnoremap <leader>r :VimuxRunCommand "bundle exec rspec ".@%<cr>
nnoremap <leader>rf :VimuxRunCommand "bundle exec rspec ".@%." --tag focus"<cr>

" Run rubocop on current file
nnoremap <leader>b :VimuxRunCommand "bundle exec rubocop ".@%<cr>

" Enable 256 color support in tmux <http://superuser.com/questions/399296/256-color-support-for-vim-background-in-tmux>
set t_ut=

" vim-gutentags
let g:gutentags_ctags_tagfile='.git/tags'
let g:gutentags_generate_on_write=0
let g:gutentags_exclude = [
      \ '*.min.js',
      \ '*html*',
      \ 'jquery*.js',
      \ '*/vendor/*',
      \ '*/node_modules/*',
      \ '*/python2.7/*',
      \ '*/migrate/*.rb'
      \ ]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ deoplete#mappings#manual_complete()
		function! s:check_back_space() abort "{{{
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
		endfunction"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Denite
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction

call denite#custom#option('_', {
     \ 'prompt': '❯',
     \ 'winheight': 10,
     \ 'updatetime': 1,
     \ 'auto_resize': 0,
     \ 'highlight_matched_char': 'Underlined',
     \ 'highlight_mode_normal': 'CursorLine',
     \ 'reversed': 1,
     \ 'auto-accel': 1,
     \ 'start_filter': 1,
     \})

nnoremap <C-p> :<C-u>Denite file/rec<CR>
nnoremap <leader>s :<C-u>Denite buffer<CR>

" Change file/rec command.
call denite#custom#var('file/rec', 'command',
\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')

  nnoremap <silent><buffer><expr> <Tab>    denite#do_map('choose_action')
  nnoremap <silent><buffer><expr> <ESC>   denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
endfunction

autocmd FileType denite-filter call s:denite_filter_settings()
function s:denite_filter_settings() abort
  setl nonumber
  call deoplete#custom#buffer_option('auto_complete', v:false)

  inoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
  inoremap <silent><buffer> <CR>  <ESC><C-w>p:call denite#call_map('do_action')<CR>
  inoremap <silent><buffer> <Tab>   <Esc><C-w>p:call denite#call_map('choose_action')<CR>
  inoremap <silent><buffer> <Space> <Esc><C-w>p:call denite#call_map('toggle_select')<CR><C-w>pA
  inoremap <silent><buffer> <C-j>   <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
  inoremap <silent><buffer> <C-k>   <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The Silver Searcher <http://robots.thoughtbot.com/faster-grepping-in-vim>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ackprg = 'ag --vimgrep'
endif

" bind K to grep word under cursor
nnoremap K :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ack<SPACE>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linting <https://github.com/mhartington/dotfiles/blob/master/vimrc>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function! neomake#makers#ft#javascript#eslint()
"    return {
"        \ 'args': ['-f', 'compact'],
"        \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
"        \ '%W%f: line %l\, col %c\, Warning - %m'
"        \ }
" endfunction
"
" let g:neomake_javascript_enabled_makers = ['eslint']

autocmd! BufWritePost * Neomake

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
