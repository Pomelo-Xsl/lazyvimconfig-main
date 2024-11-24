return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
      },
    },
  },
}
