-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Custom dictionary words imported from VS Code cSpell
local user_words = { "cgpa", "cust", "EMPS", "nume", "Nutella" }
for _, word in ipairs(user_words) do
  vim.cmd("silent! spellgood " .. word)
end

-- Enforce strict 4-space indentation across web and systems programming languages
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "python", "javascript", "typescript", "javascriptreact", "typescriptreact", "html", "css" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})
