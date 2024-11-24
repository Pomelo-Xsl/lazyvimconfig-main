return {
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function(_, opts)
      opts.debugger = { enabled = true }
    end,
    specs = {
      -- Add "flutter" extension to "telescope"
      {
        "nvim-telescope/telescope.nvim",
        optional = true,
        opts = function()
          require("telescope").load_extension("flutter")
        end,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = { "sidlatau/neotest-dart" },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-dart")({
          command = "fvm flutter",
          use_lsp = true,
          custom_test_method_names = { "testWidgets" },
        })
      )
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "williamboman/mason.nvim",
      optional = true,
      opts = { ensure_installed = { "dart-debug-adapter" } },
    },
    config = function()
      local dap = require("dap")
      dap.adapters.dart = {
        type = "executable",
        command = "flutter",
        args = { "debug_adapter" },
      }
      dap.configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch Dart Program",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   optional = true,
  --   opts = {
  --     servers = {
  --       dartls = {},
  --     },
  --   },
  -- },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = {
      handlers = {
        dartls = function() end,
      },
      ensure_installed = { "dart" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = { "dart" } },
  },
}
