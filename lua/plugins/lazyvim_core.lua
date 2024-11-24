return {
  {
    "folke/tokyonight.nvim",
    optional = true,
    opts = {
      transparent = false,
      style = "night",
    },
  },
  {
    "folke/flash.nvim",
    optional = true,
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = false, -- 去掉搜索的选择
        },
        char = {
          enabled = false, -- 去掉f和t的字符跳转
        },
      },
    },
    keys = {
      {
        "f",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "F",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          -- set to `false` to disable one of the mappings
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<TAB>",
          node_decremental = "<BS>",
        },
      },
      -- 可以避免一些错误的缩进
      indent = { enable = false },
    },
  },
  {
    "folke/noice.nvim",
    optional = true,
    opts = {
      lsp = {
        -- 使用了更好的插件来完成
        signature = {
          enabled = false,
        },
        -- 优化hover
        hover = {
          enabled = true,
        },
        -- 这个是lsp加载条，会导致卡顿
        progress = {
          enabled = false,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "AutoSave: saved at " },
            },
          },
          view = "mini",
        },
        -- 这是蓝色搜索条
        -- 禁用搜索计数的虚拟文本，我有更好的
        -- {
        --   filter = {
        --     event = "msg_show",
        --     kind = "search_count",
        --   },
        --   opts = { skip = true },
        -- },
      },
      presets = {
        long_message_to_split = false, -- long messages will be sent to a split
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    init = function()
      vim.g.lsp_handlers_enabled = false
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    optional = true,
    opts = function(_, opts)
      local logo = table.concat({
        "███    ███  █████  ██████  ██      ███████ ",
        "████  ████ ██   ██ ██   ██ ██      ██      ",
        "██ ████ ██ ███████ ██████  ██      ███████ ",
        "██  ██  ██ ██   ██ ██      ██      ██      ",
        "██      ██ ██   ██ ██      ███████ ███████ ",
      }, "\n")
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
      return opts
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      local cmp = require("cmp")
      -- 默认不选第一个选择
      opts.preselect = cmp.PreselectMode.None
      opts.completion.completeopt = "menu,menuone,noselect"
      opts.window = {
        -- 设置一个边界
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
      opts.mapping["<C-y>"] = cmp.mapping(cmp.mapping.complete())
      opts.mapping["<C-e>"] = cmp.mapping(cmp.mapping.abort())
      opts.mapping["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }))
      opts.mapping["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }))
      opts.mapping["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }))
      opts.mapping["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }))
      return opts
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    optional = true,
    opts = function(_, opts)
      opts.layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.25,
            },
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
            {
              id = "watches",
              size = 0.25,
            },
          },
          position = "right",
          size = 35,
        },
        {
          elements = {
            {
              id = "repl",
              size = 0.5,
            },
            {
              id = "console",
              size = 0.5,
            },
          },
          position = "bottom",
          size = 8,
        },
      }
      -- 文字超过窗口
      opts.expand_lines = true
      return opts
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            -- 整个窗口的高度
            height = 0.99,
            preview_cutoff = 1,
            preview_height = 0.55,
            prompt_position = "bottom",
            width = 0.9,
          },
        },
      },
    },
  },
}
