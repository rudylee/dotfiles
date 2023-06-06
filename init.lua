vim.opt.encoding = 'utf-8' -- Set encoding to UTF-8
vim.opt.compatible = false -- Disable compatibility with Vi
vim.opt.number = true -- Show line numbers
vim.opt.backup = false -- Disable backups
vim.opt.cursorline = false -- Disable highlighting of current line
vim.opt.cursorcolumn = false -- Disable highlighting of current column
vim.opt.writebackup = false -- Disable write backups
vim.opt.swapfile = false -- Disable swap files
vim.opt.hlsearch = true -- Enable search highlighting
vim.opt.ruler = true -- Show the status line
vim.opt.laststatus = 2 -- Always show the status line
vim.opt.tabstop = 2 -- Set tab size
vim.opt.shiftwidth = 2 -- Set indent size
vim.opt.scrolljump = 5 -- Set scroll jump
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.hidden = true -- Enable hiding of unsaved buffers
vim.opt.lazyredraw = true -- Enable lazy redraw to speed up macro playback
vim.opt.ttyfast = true -- Enable fast terminal mode
vim.api.nvim_command('set cursorline!') -- Toggle highlighting of the current line
vim.opt.autoindent = true -- Enable autoindent
vim.opt.cindent = true -- Enable C-style indenting
vim.opt.smartindent = true -- Enable smart indenting
vim.opt.synmaxcol = 128 -- Set maximum column for syntax highlighting

-- Plugin manager setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'nvim-tree/nvim-web-devicons',
  'nvim-tree/nvim-tree.lua',
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-rhubarb',
  'tomtom/tcomment_vim',
  'mileszs/ack.vim',
  'benmills/vimux',
  'nvim-lua/popup.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-fzy-native.nvim',
  'ojroques/vim-oscyank',
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',
  'VonHeikemen/lsp-zero.nvim',
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require'nvim-treesitter.configs'.setup {
        indent = {
          enable = true
        }
      }
    end,
  }
})

-- Colorscheme
if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end
vim.cmd('syntax enable')
vim.cmd[[colorscheme tokyonight-moon]]
vim.cmd('highlight Comment cterm=italic gui=italic')

-- Set up leader key to <,>
vim.g.mapleader = ","

-- Map Keys for Managing Buffers
vim.api.nvim_set_keymap('n', '<C-J>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-K>', ':bprev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-L>', ':tabn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-H>', ':tabp<CR>', { noremap = true, silent = true })

-- Map CTRL+S to save file
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<ESC>:w<CR>a', { noremap = true })

-- Map CTRL+Q to close buffer
vim.api.nvim_set_keymap('n', '<C-q>', ':bp|bd #<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-q>', '<ESC>:bd #<CR>', { noremap = true })

-- Create new buffer
vim.api.nvim_set_keymap('n', '<leader>B', ':enew<CR>', { noremap = true })

-- Close all buffers
vim.api.nvim_set_keymap('n', '<leader>ba', ':bufdo bd!<CR>', { noremap = true })

-- Map semicolon to colon
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })

-- Key mapping for tab
vim.api.nvim_set_keymap('n', '<C-t>', '<esc>:tabnew<CR>', { noremap = true })

-- Key mapping for window management
vim.api.nvim_set_keymap('n', '<C-x>', '<C-w>c', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>w', '<C-w>w', { noremap = true })

-- Edit Vimrc
vim.cmd('command! Vimrc vs $MYVIMRC')

-- Clean trailing whitespace
vim.api.nvim_set_keymap('n', '<leader>ww', "mz:%s/\\s\\+$//<cr>:let @/=''<cr>`z", { noremap = true })

-- Prettify JSON
vim.api.nvim_set_keymap('n', '<leader>pp', ":%!python -m json.tool<cr>", { noremap = true })

-- Enable 256 color support in tmux
vim.cmd("set t_ut=")

-- OSCYank
vim.api.nvim_set_keymap('n', '<Leader>y', ":OSCYank<CR>", { noremap = true })
vim.g.oscyank_max_length = 1000000

-- Gist
vim.g.gist_post_private = 1

-- Move visual block
vim.api.nvim_set_keymap('v', 'J', "'>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap('v', 'K', "'<-2<CR>gv=gv", { noremap = true })

--[[
NvimTree
]]
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nf', ':NvimTreeFindFile<CR>', { noremap = true })
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local function nvim_tree_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- BEGIN_DEFAULT_ON_ATTACH
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
  vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab,                     opts('Open: New Tab'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal,              opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
  vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview,                 opts('Open Preview'))
  vim.keymap.set('n', '>',     api.node.navigate.sibling.next,        opts('Next Sibling'))
  vim.keymap.set('n', '<',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
  vim.keymap.set('n', '.',     api.node.run.cmd,                      opts('Run Command'))
  vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
  vim.keymap.set('n', 'bmv',   api.marks.bulk.move,                   opts('Move Bookmarked'))
  vim.keymap.set('n', 'B',     api.tree.toggle_no_buffer_filter,      opts('Toggle No Buffer'))
  vim.keymap.set('n', 'c',     api.fs.copy.node,                      opts('Copy'))
  vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Git Clean'))
  vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
  vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
  vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
  vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
  vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
  vim.keymap.set('n', 'e',     api.fs.rename_basename,                opts('Rename: Basename'))
  vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
  vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
  vim.keymap.set('n', 'F',     api.live_filter.clear,                 opts('Clean Filter'))
  vim.keymap.set('n', 'f',     api.live_filter.start,                 opts('Filter'))
  vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
  vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
  vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
  vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
  vim.keymap.set('n', 'm',     api.marks.toggle,                      opts('Toggle Bookmark'))
  vim.keymap.set('n', 'o',     api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', 'O',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
  vim.keymap.set('n', 'p',     api.fs.paste,                          opts('Paste'))
  vim.keymap.set('n', 'P',     api.node.navigate.parent,              opts('Parent Directory'))
  vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
  vim.keymap.set('n', 'r',     api.fs.rename,                         opts('Rename'))
  vim.keymap.set('n', 'R',     api.tree.reload,                       opts('Refresh'))
  vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System'))
  vim.keymap.set('n', 'S',     api.tree.search_node,                  opts('Search'))
  vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         opts('Toggle Hidden'))
  vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
  vim.keymap.set('n', 'x',     api.fs.cut,                            opts('Cut'))
  vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
  vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
  vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
  -- END_DEFAULT_ON_ATTACH

  vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
end

require("nvim-tree").setup({
  on_attach = nvim_tree_on_attach,
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})


--[[
LSP
]]
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.ensure_installed({
  'tsserver',
  'solargraph',
})
lsp.setup()

--[[
Telescope
]]
vim.api.nvim_set_keymap('i', '<TAB>', 'pumvisible() ? "<C-n>" : "<TAB>"', { expr = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', ":lua require('telescope.builtin').find_files()<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>s', "<cmd>lua require('telescope.builtin').buffers()<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>g', "<cmd>lua require('telescope.builtin').git_status()<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', "<cmd>lua require('telescope.builtin').treesitter()<cr>", { silent = true })

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

--[[
Ack
]]
if vim.fn.executable('rg') == 1 then
  -- Use rg over grep
  vim.opt.grepprg = 'rg --nogroup --nocolor'

  vim.g.ackprg = 'rg --vimgrep -g "!doc/*" -g "!docs/*"'
end

-- Bind K to grep word under cursor
vim.api.nvim_set_keymap('n', 'K', ':Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>', { silent = true })

-- Bind \ (backward slash) to grep shortcut
vim.cmd("command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!")

vim.api.nvim_set_keymap('n', '\\', ':Ack<SPACE>', { silent = true })
