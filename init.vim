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
set cursorline!
setlocal autoindent
setlocal cindent
setlocal smartindent

" Plugins
call plug#begin('~/.vim/plugged')

" Tools
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'Shougo/denite.nvim', { 'commit': '49358751031dd26648befa671332af887a0aa62b' }
Plug 'tomtom/tcomment_vim'
Plug 'mileszs/ack.vim'
Plug 'benmills/vimux'
Plug 'ludovicchabant/vim-gutentags'

" Window
Plug 'roman/golden-ratio'

" HTML
Plug 'othree/html5.vim'

" Colorscheme and UI
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'

" Ruby
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

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
let g:deoplete#auto_complete_delay = 0
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
call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '--ignore', 'node_modules', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'default_opts', ['--follow', '--no-group', '--no-color'])

" Change mappings.
call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-d>',
      \ '<denite:do_action:delete>',
      \ 'noremap'
      \)

nnoremap <C-p> :<C-u>Denite file/rec<CR>
nnoremap <leader>s :<C-u>Denite buffer<CR>

augroup deniteresize
  autocmd!
  autocmd VimResized,VimEnter * call denite#custom#option('default',
        \'winheight', winheight(0) / 3)
augroup end

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

let g:neomake_javascript_enabled_makers = ['eslint']

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
