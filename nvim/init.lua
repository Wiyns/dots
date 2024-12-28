-- lazy.nvim install
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- editor configs
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 3
vim.o.shiftwidth = 3
vim.o.expandtab = true

-- plugins
require("lazy").setup({
   { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
   { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies =    { 'nvim-lua/plenary.nvim' } },
   { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
   { "folke/which-key.nvim",  enabled = true },
   { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons",  "MunifTanjim/nui.nvim", } },
   { 'saghen/blink.cmp', lazy = false, dependencies = 'rafamadriz/friendly-snippets', version = 'v0.*', opts = { keymap = { preset = 'super-tab' },highlight = { use_nvim_cmp_as_default = true, }, nerd_font_variant = 'normal', sources = { completion = { enabled_providers = { 'lsp', 'path', 'snippets', 'buffer' }, }, }, }, opts_extend = { "sources.completion.enabled_providers" } },
   { 'neovim/nvim-lspconfig', dependencies = { 'saghen/blink.cmp' }, config = function(_, opts) local lspconfig = require('lspconfig') for server, config in pairs(opts.servers or {}) do config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities) lspconfig[server].setup(config) end end },
   { 'windwp/nvim-autopairs', event = "InsertEnter", config = true },
   { "iamcco/markdown-preview.nvim"}, cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }, build = "cd app && yarn install", init = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }
})

-- plugin configs
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'catppuccin-mocha',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filesize', 'fileformat', 'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- set theme 
vim.cmd.colorscheme "catppuccin-mocha"
