-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- ---------- 插入模式 ---------- --
vim.keymap.set("i", "jj", "<Esc>")

-- ---------- 正常模式 ---------- --
-- 重做
vim.keymap.set("n", "U", "<C-r>")
-- 取消搜索高亮
vim.keymap.set("n", "<leader>h", "<cmd>:nohl<CR>", { desc = "No Highlight" })
-- 光标移到最左/右
vim.keymap.set("n", "<S-h>", "^")
vim.keymap.set("n", "<S-l>", "$")
-- 从终端退出
vim.keymap.set("t", "JJ", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

-- ---------- 视觉模式 ---------- --
-- 光标移到最左/右，非空白字符
vim.keymap.set("v", "<S-h>", "^")
vim.keymap.set("v", "<S-l>", "$g_")
-- 光标移到最右非空格字符
vim.keymap.set("v", "$", "$g_")
