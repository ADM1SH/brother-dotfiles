return {
    -- ErrorLens for Neovim (matches VS Code ErrorLens extension)
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = function()
            require("tiny-inline-diagnostic").setup({
                preset = "modern",
                options = {
                    show_source = true,
                    use_icons_from_diagnostic = true,
                    add_messages = true,
                    throttle = 20,
                    softwrap = 30,
                    multilines = {
                        enabled = true,
                        always_show = false,
                    },
                },
            })
            -- Disable standard virtual text so tiny-inline-diagnostic handles it cleanly
            vim.diagnostic.config({ virtual_text = false })
        end,
    },

    -- Colorizer (matches VS Code Color Highlight extension)
    {
        "brenoprata10/nvim-highlight-colors",
        event = "BufReadPost",
        opts = {
            render = "background",
            enable_hex = true,
            enable_rgb = true,
            enable_hsl = true,
            enable_var_usage = true,
            enable_named_colors = true,
            enable_tailwind = true,
        },
    },

    -- GitLens style inline blame & annotations (matches VS Code GitLens)
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 300,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = "   <author>, <author_time:%R> • <summary>",
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
        },
    },
}
