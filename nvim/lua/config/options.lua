-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Indentation: Strict 4 spaces (matching user coding style)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftround = true

-- System Clipboard sync (matching VS Code copy/paste)
vim.opt.clipboard = "unnamedplus"

-- Auto save on focus lost / leave buffer (matching VS Code autoSave)
vim.opt.autowriteall = true

-- Search & UI (Vim Motions & Visuals)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false -- Prefer non-wrapped code views
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 4

-- Fast update time for live GitLens blame & diagnostics
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300

-- Spell checking & custom dictionary (matching VS Code cSpell userWords)
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
