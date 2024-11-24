local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- 这个是行移动
    { import = "lazyvim.plugins.extras.editor.mini-move" },

    -- 用来debug的
    { import = "lazyvim.plugins.extras.dap.core" },

    -- 颜色显示
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },

    -- codeium的ai补全
    { import = "lazyvim.plugins.extras.ai.codeium" },
    { import = "extras.codeium" },

    -- copilot的ai补全
    { import = "lazyvim.plugins.extras.ai.copilot" },
    { import = "lazyvim.plugins.extras.ai.copilot-chat" },

    -- 这个是代码导航
    { import = "lazyvim.plugins.extras.editor.navic" },

    -- 对一些点文件进行支持
    { import = "lazyvim.plugins.extras.util.dot" },

    -- 对字符包裹
    { import = "lazyvim.plugins.extras.coding.mini-surround" },

    -- html的支持
    { import = "extras.html" },

    -- lua的运行配置
    { import = "extras.lua" },

    { import = "lazyvim.plugins.extras.lang.vue" },

    { import = "lazyvim.plugins.extras.lang.clangd" },
    { import = "extras.clangd" },

    { import = "lazyvim.plugins.extras.lang.cmake" },
    { import = "extras.cmake" },

    { import = "lazyvim.plugins.extras.lang.java" },

    { import = "lazyvim.plugins.extras.lang.json" },

    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "extras.markdown" },

    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "extras.python" },

    { import = "lazyvim.plugins.extras.lang.yaml" },

    { import = "lazyvim.plugins.extras.lang.tailwind" },

    { import = "lazyvim.plugins.extras.ui.mini-animate" },

    -- flutter的支持
    { import = "extras.dart-flutter" },

    -- 导入一个目录的插件
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
