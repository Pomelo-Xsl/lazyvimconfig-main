-- 这个是neovide的设置

if vim.fn.has("win32") == 1 then
  -- 在Windows上运行的代码
  vim.o.guifont = "Maple Mono SC NF:h12.5"
elseif vim.fn.has("unix") == 1 then
  -- 在Unix-like系统（包括Linux和macOS）上运行的代码
  if vim.fn.has("macunix") == 1 then
    -- 在macOS上运行的代码
  else
    -- 在Linux上运行的代码
    vim.o.guifont = "Maple Mono SC NF:h12.5"
  end
else
  -- 在其他操作系统上运行的代码
  print("This is an unsupported operating system.")
end

-- 将 g:neovide_no_idle 设置为布尔值将强制 Neovide 始终重绘。如果动画似乎停止得太早，这可能是一个快速解决方案。
vim.g.neovide_no_idle = true
-- 退出确认
vim.g.neovide_confirm_quit = true
-- 全屏(没有任务栏的那种)
vim.g.neovide_fullscreen = false
-- 记住窗口大小
vim.g.neovide_remember_window_size = true
-- 没有焦点的时候的刷新率
vim.g.neovide_refresh_rate_idle = 5
-- 普通刷新率
vim.g.neovide_refresh_rate = 60
-- 滚动动画的时间
vim.g.neovide_scroll_animation_length = 0.3

vim.opt.clipboard:append("unnamedplus")

return {
  -- 预览跳转
  {
    "nacro90/numb.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = {
      show_numbers = true, -- Enable 'number' for the window while peeking
      show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
      number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
      centered_peeking = true, -- Peeked line will be centered relative to window
    },
  },
  -- 字符反转
  {
    "nguyenvukhang/nvim-toggler",
    event = "BufEnter",
    config = function()
      require("nvim-toggler").setup({
        -- init.lua
        -- your own inverses
        inverses = {
          ["True"] = "False",
        },
        -- removes the default <leader>i keymap
        remove_default_keybinds = true,
        vim.keymap.set({ "n", "v" }, "<leader>i", require("nvim-toggler").toggle, { desc = "Reverse Text" }),
      })
    end,
  },
  -- 字符匹配 if else
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "andymass/vim-matchup" },
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup", fullwidth = 1, highlight = "Normal", syntax_hl = 1 }
    end,
    opts = { matchup = { enable = true } },
  },
  -- cmd的辅助
  {
    "hrsh7th/cmp-cmdline",
    keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
    dependencies = { "hrsh7th/nvim-cmp" },
    opts = function()
      local cmp = require("cmp")
      return {
        {
          type = "/",
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        },
        {
          type = ":",
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            {
              name = "cmdline",
              option = {
                ignore_cmds = { "Man", "!" },
              },
            },
          }),
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      vim.tbl_map(function(val)
        cmp.setup.cmdline(val.type, val)
      end, opts)
    end,
  },
  -- 参数提示
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "ray-x/lsp_signature.nvim",
      opts = function(_, opts)
        -- vim.keymap.set({ "n", "i" }, "<M-s>", function()
        --   require("lsp_signature").toggle_float_win()
        -- end, { silent = true, noremap = true, desc = "toggle signature" })

        opts.hint_enable = false -- disable hints as it will crash in some terminal
        return opts
      end,
    },
  },
  -- lsp加载显示
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },
  {
    "ryanmsnyder/toggleterm-manager.nvim",
    dependencies = {
      "akinsho/nvim-toggleterm.lua",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
    },
    keys = {
      { "<leader>wt", "<cmd>Telescope toggleterm_manager<cr>", desc = "Search Toggleterms" },
    },
    opts = function(_, opts)
      local actions = require("toggleterm-manager").actions
      opts.mappings = { -- key mappings bound inside the telescope window
        n = {
          ["<CR>"] = { action = actions.toggle_term, exit_on_action = true }, -- toggles terminal open/closed
          ["i"] = { action = actions.create_term, exit_on_action = false }, -- creates a new terminal buffer
          ["d"] = { action = actions.delete_term, exit_on_action = false }, -- deletes a terminal buffer
          ["r"] = { action = actions.rename_term, exit_on_action = false }, -- provides a prompt to rename a terminal
        },

        i = {
          ["<CR>"] = { action = actions.toggle_term, exit_on_action = true }, -- toggles terminal open/closed
          ["<C-i>"] = { action = actions.create_term, exit_on_action = false }, -- creates a new terminal buffer
          ["<C-d>"] = { action = actions.delete_term, exit_on_action = false }, -- deletes a terminal buffer
          ["<C-r>"] = { action = actions.rename_term, exit_on_action = false }, -- provides a prompt to rename a terminal
        },
      }
      return opts
    end,
    config = true,
  },
  -- 滚动插件
  -- {
  --   "declancm/cinnamon.nvim",
  --   version = "*", -- use latest release
  --   opts = {
  --     -- change default options here
  --   },
  -- },
  -- 注释的插件
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
  },
}
