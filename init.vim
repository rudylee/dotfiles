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
Plug 'raghur/fruzzy'
Plug 'tomtom/tcomment_vim'
Plug 'mileszs/ack.vim'
Plug 'benmills/vimux'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Github tool
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

" HTML
Plug 'othree/html5.vim'

" Colorscheme and UI
Plug 'morhetz/gruvbox'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Go
Plug 'fatih/vim-go'

" GraphQL
Plug 'jparise/vim-graphql'

" Plug 'rudylee/nvim-gist'

" Autocomplete
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#end()

if (has("termguicolors"))
 set termguicolors
endif
syntax enable
let g:tokyonight_style = "storm"
colorscheme tokyonight
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
" LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require'lspconfig'.solargraph.setup{}
require'lspconfig'.tsserver.setup{}
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-compe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}
EOF

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
" Treesitter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua <<EOF
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Telescope
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
lua << EOF
require('telescope').load_extension('fzy_native')

local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
        ["<c-d>"] = actions.delete_buffer,
     },
      n = {
        ["<esc>"] = actions.close,
      },
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      }
    },
    file_ignore_patterns = {"doc/.*", "docs/.*"}
  }
}
EOF
nnoremap <C-p> :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>s <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>g <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>f <cmd>lua require('telescope.builtin').treesitter()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ack
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('rg')
  " Use rg over grep
  set grepprg=rg\ --nogroup\ --nocolor

  let g:ackprg = 'rg --vimgrep -g "!doc/*" -g "!docs/*"'
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
