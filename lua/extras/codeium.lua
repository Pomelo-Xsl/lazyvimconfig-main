local Path = require("plenary.path")
local nvim_data_codeium_path = tostring(Path:new(vim.fn.stdpath("data"), "codeium"))

return {
  "Exafunction/codeium.nvim",
  opts = {
    config_path = tostring(Path:new(nvim_data_codeium_path, "config.json")),
    bin_path = tostring(Path:new(nvim_data_codeium_path, "bin")),
  },
}
