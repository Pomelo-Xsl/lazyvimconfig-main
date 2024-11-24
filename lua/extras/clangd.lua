return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        clangd = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja",
              "CMakeLists.txt",
              "main.cpp",
              ".clangd",
              ".clang-tidy",
              ".clang-format"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          cmd = {
            require("config.fishfunc").OsCho("clangd.exe", "clangd", "clangd", "clangd"),
            -- 主要标志
            -- "--compile-commands-dir=build/Debug/.qtc_clangd", -- qt配置编译命令文件
            -- "--compile-commands-dir=build/Debug", -- nvim的cmake配置编译命令文件
            "--compile-commands-dir=build", -- nvim的cmake配置编译命令文件
            -- "--query-driver=D:/CodeBin/Qt/Tools/mingw1120_64/bin/gcc-*.exe,D:/CodeBin/Qt/Tools/mingw1120_64/bin/g++-*.exe",

            -- 功能
            "--all-scopes-completion", -- 全代码库补全
            "--background-index",
            "--background-index-priority=normal", -- 在后台自动分析代码
            "--clang-tidy", -- 格式化代码，目录下需要放一个.clang-format文件
            "--completion-style=bundled", -- (detailed or bundled)补全的方法时候显示参数，按tab下一项的那种
            "--fallback-style=WebKit", -- webkit microsoft gun都还不错(按喜好顺序排)
            "--header-insertion=iwyu", -- (iwyu or never)禁止头文件插入
            "--header-insertion-decorators", -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分

            -- clangd的性能
            "-j=16", -- 后台线程数，可根据机器配置自行调整
            "--pch-storage=memory", -- 用内存性能更好

            -- clangd信息
            "--log=error",
            "--pretty", -- 输出的 JSON 文件更美观
          },
        },
        qmlls = {
          -- root_dir = function(fname)
          --   return require("lspconfig.util").root_pattern(
          --     "Makefile",
          --     "configure.ac",
          --     "configure.in",
          --     "config.h.in",
          --     "meson.build",
          --     "meson_options.txt",
          --     "build.ninja",
          --     "CMakeLists.txt",
          --     "main.cpp",
          --     ".clangd",
          --     ".clang-tidy",
          --     ".clang-format"
          --   )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
          --     fname
          --   ) or require("lspconfig.util").find_git_ancestor(fname)
          -- end,
          cmd = {
            "D:/CodeBin/Qt/Tools/QtDesignStudio/qt6_design_studio_reduced_version/bin/qmlls.exe",
          },
        },
      },
    },
  },
}
