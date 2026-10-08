return {
    -- mini.surround configuration matching Omerxx dotfiles
    {
        "nvim-mini/mini.surround",
        opts = {
            mappings = {
                add = "sa",
                delete = "sd",
                find = "gsf",
                find_left = "gsF",
                highlight = "gsh",
                replace = "gsr",
                update_n_lines = "gsn",
            },
        },
    },

    -- Treesitter Text Objects (Functions, Classes, Blocks, Parameters)
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = "VeryLazy",
    },
}
