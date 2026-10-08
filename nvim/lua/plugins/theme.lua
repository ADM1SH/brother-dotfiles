return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = false,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- Default High Contrast (matching VS Code theme)
      colorscheme = "github_dark_high_contrast",
    },
  },
}
