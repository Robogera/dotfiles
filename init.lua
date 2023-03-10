vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.cmd.colorscheme "catppuccin-macchiato"
vim.opt.encoding = 'utf-8'
vim.opt.backspace = 'indent,eol,start'
vim.opt.startofline = true
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100
vim.opt.showmatch = true
vim.opt.scrolloff = 12
vim.opt.list = false
vim.opt.foldenable = false
vim.opt.wrap = true
vim.cmd(':set linebreak breakindent')
vim.opt.eol = false
vim.opt.showbreak = '↪ '
vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.signcolumn = 'yes'
vim.opt.modelines = 0
vim.opt.showcmd = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.matchtime = 1
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.wildmenu = true

vim.opt.updatetime = 300

require( 'plugins' )

vim.diagnostic.config({
  virtual_text = false,
})

vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]


vim.g.mapleader = ' '
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>b', '<Cmd>BufferLineCyclePrev<CR>', {})
vim.keymap.set('n', '<leader>n', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<leader>p', '<Cmd>BufferLinePick<CR>', {})
vim.keymap.set('n', '<leader>cc', '<Cmd>BufferLinePickClose<CR>', {})
vim.keymap.set('n', '<leader>cl', '<Cmd>BufferLineCloseLeft<CR>', {})
vim.keymap.set('n', '<leader>cr', '<Cmd>BufferLineCloseRight<CR>', {})

vim.keymap.set('n', '<leader>t', '<Cmd>NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<leader>-', '<Cmd>NvimTreeResize -2<CR>', {})
vim.keymap.set('n', '<leader>=', '<Cmd>NvimTreeResize +2<CR>', {})

vim.keymap.set('n', '<leader>hs', '<Cmd>GitGutterStageHunk<CR>', {})
vim.keymap.set('n', '<leader>hu', '<Cmd>GitGutterUndoHunk<CR>', {})
vim.keymap.set('n', '<leader>hp', '<Cmd>GitGutterPreviewHunk<CR>', {})
vim.keymap.set('n', '<leader>hn', '<Cmd>GitGutterNextHunk<CR>', {})
vim.keymap.set('n', '<leader>hb', '<Cmd>GitGutterPrevHunk<CR>', {})

local diagnosticSigns = {
    Error = "",
    Warning = "",
    Hint = "",
    Information = "",
}

for severity, sign in pairs(diagnosticSigns) do
    local hlGroup = "DiagnosticSign" .. severity
    vim.fn.sign_define(hlGroup, {texthl = hlGroup, numhl = hlGroup, text = sign})
end

vim.g.coq_settings = {
  auto_start = "shut-up",
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp = require "lspconfig"
local coq = require "coq"

lsp.gopls.setup(coq.lsp_ensure_capabilities())
lsp.ansiblels.setup(coq.lsp_ensure_capabilities())
lsp.clangd.setup(coq.lsp_ensure_capabilities())

