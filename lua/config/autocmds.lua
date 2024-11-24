-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
  -- group = augroup("close_with_q"),
  pattern = {
    -- "PlenaryTestPopup",
    -- "help",
    -- "lspinfo",
    -- "man",
    -- "notify",
    -- "qf",
    -- "spectre_panel",
    -- "startuptime",
    -- "tsplayground",
    -- "neotest-output",
    -- "checkhealth",
    -- "neotest-summary",
    -- "neotest-output-panel",

    -- add
    "cmake_tools_terminal",
    "dap-repl",
    "dap-console",
    "dap-watches",
    "DressingInput",
    "toggleterm",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- remove comment when go to next line
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "*",
  },
  callback = function()
    -- 执行指令
    vim.cmd("setlocal formatoptions-=c formatoptions-=r formatoptions-=o")
  end,
})

-- set cpp comment style
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "cpp",
    "c",
  },
  callback = function()
    -- 执行指令
    vim.cmd("setlocal commentstring=//\\ %s")
  end,
})

-- if vim.fn.has("win32") == 1 then
--   -- 设置powsershell为默认终端
--   -- https://stackoverflow.com/questions/36108950/setting-up-powershell-as-vims-shell-command-does-not-seem-to-be-passed-correct
--   vim.cmd([[
--             set shell=pwsh
--             set shellcmdflag=-command
--             set shellquote=\"
--             set shellxquote=
--             ]])
-- end
