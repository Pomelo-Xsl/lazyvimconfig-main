return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        markdown = { { "prettierd", "prettier" } },
      },
    },
  },
  {
    "lukas-reineke/headlines.nvim",
    optional = true,
    enabled = false,
  },
  {
    "iamcco/markdown-preview.nvim",
    enabled = false,
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("render-markdown").setup({})
    end,
  },
  -- {
  --   -- "wallpants/github-preview.nvim",
  --   dir = "D:/Desktop/temp/code/github-preview.nvim",
  --   -- dev = true,
  --   cmd = { "GithubPreviewToggle" },
  --   keys = { "<leader>mpt" },
  --   opts = {
  --     -- config goes here
  --     log_level = "debug",
  --   },
  --   config = function(_, opts)
  --     local gpreview = require("github-preview")
  --     gpreview.setup(opts)
  --
  --     local fns = gpreview.fns
  --     vim.keymap.set("n", "<leader>mpt", fns.toggle)
  --     vim.keymap.set("n", "<leader>mps", fns.single_file_toggle)
  --     vim.keymap.set("n", "<leader>mpd", fns.details_tags_toggle)
  --   end,
  -- },
}
