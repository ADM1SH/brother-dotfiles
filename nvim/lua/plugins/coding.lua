return {
    -- Multi-Cursor Editing (matches VS Code Ctrl+D / Multi-Cursor)
    {
        "mg979/vim-visual-multi",
        event = "BufReadPost",
        init = function()
            vim.g.VM_maps = {
                ["Find Under"] = "<C-d>",
                ["Find Subword Under"] = "<C-d>",
            }
        end,
    },

    -- Template String Converter (matches VS Code template-string-converter)
    -- Automatically converts "" or '' to `` when typing ${ in JS/TS
    {
        "axelvc/template-string.nvim",
        ft = {
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "vue",
            "svelte",
            "python",
        },
        opts = {
            filetypes = {
                "javascript",
                "typescript",
                "javascriptreact",
                "typescriptreact",
                "vue",
                "svelte",
                "python",
            },
            jsx_brackets = true,
            remove_template_string = true,
            restore_quotes = {
                normal = [[']],
                jsx = [["]],
            },
        },
    },

    -- Debounced Auto-Save (matches VS Code files.autoSave: "afterDelay")
    {
        "okuuva/auto-save.nvim",
        cmd = "ASToggle",
        event = { "InsertLeave", "TextChanged" },
        opts = {
            enabled = true,
            execution_message = {
                enabled = false,
            },
            trigger_events = {
                immediate_save = { "BufLeave", "FocusLost" },
                defer_save = { "InsertLeave", "TextChanged" },
                cancel_deferred_save = { "InsertEnter" },
            },
            condition = function(buf)
                local fn = vim.fn
                if fn.getbufvar(buf, "&buftype") ~= "" then
                    return false
                end
                return true
            end,
            write_all_buffers = false,
            debounce_delay = 100,
        },
    },

    -- Side-by-side Git Diff and Git History (matches VS Code Git Graph & DiffLens)
    {
        "sindrets/diffview.nvim",
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewFileHistory",
        },
        opts = {},
    },
}
