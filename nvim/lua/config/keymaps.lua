-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- ============================================================================
-- VS Code Muscle Memory Keymaps
-- ============================================================================

-- Quick save with Ctrl+s (all modes)
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Quick Open File Finder (Ctrl+p / Cmd+p)
map("n", "<C-p>", function()
    if Snacks and Snacks.picker then
        Snacks.picker.files()
    else
        vim.cmd("FzfLua files")
    end
end, { desc = "Quick Open Files (VS Code Ctrl+P)" })

-- Toggle File Explorer Sidebar (Ctrl+b)
map("n", "<C-b>", function()
    if Snacks and Snacks.explorer then
        Snacks.explorer()
    else
        vim.cmd("Neotree toggle")
    end
end, { desc = "Toggle File Explorer (VS Code Ctrl+B)" })

-- Toggle Integrated Terminal (Ctrl+` and Ctrl+~)
map({ "n", "t" }, "<C-`>", function()
    if Snacks and Snacks.terminal then
        Snacks.terminal()
    else
        vim.cmd("terminal")
    end
end, { desc = "Toggle Terminal (VS Code Ctrl+`)" })

map({ "n", "t" }, "<C-~>", function()
    if Snacks and Snacks.terminal then
        Snacks.terminal()
    else
        vim.cmd("terminal")
    end
end, { desc = "Toggle Terminal" })

-- Toggle Comment Line (Ctrl+/ and Ctrl+_)
map({ "n", "v" }, "<C-/>", "gcc", { remap = true, desc = "Toggle Comment Line" })
map({ "n", "v" }, "<C-_>", "gcc", { remap = true, desc = "Toggle Comment Line" })

-- Move lines up and down with Alt+Up / Alt+Down (like VS Code)
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move Selection Down" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move Selection Up" })

-- Visual Mode Indentation: Keep selection active after shifting
map("v", "<", "<gv", { desc = "Indent Left & Keep Selection" })
map("v", ">", ">gv", { desc = "Indent Right & Keep Selection" })

-- Clear search highlight on pressing Esc
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- ============================================================================
-- Omerxx Vim Motions (From Video: Give Me 20 Minutes and I'll Make You a Vim Motions Expert)
-- ============================================================================

-- Fast escape from Insert mode without reaching for Esc
map("i", "jj", "<Esc>", { desc = "Exit Insert Mode" })
map("i", "jk", "<Esc>", { desc = "Exit Insert Mode" })

-- Direct line navigation (beginning of line text / end of line)
map({ "n", "v" }, "B", "^", { desc = "Jump to beginning of line text" })
map({ "n", "v" }, "E", "$", { desc = "Jump to end of line" })

-- Git DiffView shortcuts (mirrors VS Code Git Graph & Diff)
map("n", "<leader>gdo", "<cmd>DiffviewOpen<cr>", { desc = "Open Git DiffView" })
map("n", "<leader>gdc", "<cmd>DiffviewClose<cr>", { desc = "Close Git DiffView" })
map("n", "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Current File Git History" })
map("n", "<leader>gdH", "<cmd>DiffviewFileHistory<cr>", { desc = "Branch Git History Graph" })

-- ============================================================================
-- AI Agent Floating Terminals (<leader>a...)
-- ============================================================================
map("n", "<leader>ai", function()
    if Snacks and Snacks.terminal then
        Snacks.terminal("claude-personal", { win = { position = "float", width = 0.85, height = 0.85, border = "rounded" } })
    else
        vim.cmd("terminal claude-personal")
    end
end, { desc = "Toggle Claude Code Floating Terminal" })

map("n", "<leader>ag", function()
    if Snacks and Snacks.terminal then
        Snacks.terminal("agy", { win = { position = "float", width = 0.85, height = 0.85, border = "rounded" } })
    else
        vim.cmd("terminal agy")
    end
end, { desc = "Toggle Antigravity (AGY) Floating Terminal" })

map("n", "<leader>ao", function()
    if Snacks and Snacks.terminal then
        Snacks.terminal("opencode", { win = { position = "float", width = 0.85, height = 0.85, border = "rounded" } })
    else
        vim.cmd("terminal opencode")
    end
end, { desc = "Toggle OpenCode Floating Terminal" })

