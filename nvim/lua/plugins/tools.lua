return {
  -- Code Runner (mirrors VS Code Code Runner extension)
  {
    "CRAG666/code_runner.nvim",
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
    keys = {
      { "<leader>rr", "<cmd>RunFile<cr>", desc = "Run Current File" },
      { "<leader>rc", "<cmd>RunClose<cr>", desc = "Close Runner Window" },
    },
    opts = {
      mode = "float",
      float = {
        border = "rounded",
        blend = 0,
      },
      filetype = {
        python = "python3 -u",
        c = "cd $dir && gcc $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
        cpp = "cd $dir && g++ -std=c++20 $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
        javascript = "node",
        typescript = "bun || ts-node",
        rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
        sh = "bash",
      },
    },
  },

  -- Rainbow CSV (mirrors VS Code Rainbow CSV extension)
  {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe", "rfc_csv", "rfc_semicolon" },
  },
}
