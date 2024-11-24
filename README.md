# 安装、配置和问题

> nvim只是一个工具，而且没有一个全能的工具，能达到目的的就是好工具。不要试图折腾一款工具知道变成万能工具，这是不现实的。

## 快速安装

这些是依赖，目前主要更新的是windows和arch wsl。

Windows：

`scoop install nodejs fd ripgrep sed gcc make fzf gzip clangd cmake gdb rust lazygit`

archlinux:

`yay -S base-devel neovim cmake nodejs npm gdb fd unzip zip rust ripgrep lazygit`

debian(deprecate):

`sudo apt install cmake nodejs gdb fd-find unzip zip build-essential`

需要变动的包：

`sudo apt install python3.11-venv`

开始安装：

`git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim`

`git clone https:://github.com/CnsMaple/nvim_user ~/.config/nvim/lua/user`

如果想要更好的视觉体验可以使用[neovide](https://neovide.dev/installation.html)。

## 一些环境依赖问题

1. 可以显示颜色的终端。

2. Neovim >= 0.10.0（可以在文中显示虚拟文本）

3. Git >= 2.19.0

   copilot.lua插件需要git来登录：

   Linux下可能需要设置ssh通道：

   安装git，并配置git账号

   `git config --global user.name "yourname"`

   `git config --global user.email "youremail"`

   生成ssh key （生成过程中一路回车就行）

   `ssh-keygen -t rsa -C "GitHub邮箱地址"`

   找到一下这两句话，其中id_rsa.pub文件包含了你的公钥，关联账号需要用到：

   Tip:xxxx是用户名

   > Your identification has been saved in /home/xxxx/.ssh/id_rsa.
   > </br>
   > Your public key has been saved in /home/xxxx/.ssh/id_rsa.pub.

   关联GitHub账号

   获取关键内容：`cat ~/.ssh/id_rsa.pub`

   将输出都复制(从ssh-ras开头到最后)。

   打开GitHub网站：setting --> SSH and GPGS Keys --> New SSH Key-->复制cat id_rsa.pub里的秘钥到指定位置-->Add SSH Key

   验证是否成功：`ssh -T git@github.com`

   在输出中看到自己的名字就可以了，在最后一行，有"Hi,xxxx~"。

   如果出现错误：

   ```bash
   kex_exchange_identification: Connection closed by remote host
   Connection closed by 20.205.243.166 port 22
   ```

   那就改端口，在/home/xxx/.ssh/config中添加：

   ```bash
   Host github.com
       Hostname ssh.github.com
       User git
       Port 443
   ```

   ```bash
   echo "Host github.com
       Hostname ssh.github.com
       User git
       Port 443" > ~/.ssh/config
   ```

4. [a Nerd Font](https://www.nerdfonts.com/)

   目前主要在使用[maple-font](https://github.com/subframe7536/Maple-font)：`Maple Mono SC NF`

5. [ripgrep](https://github.com/BurntSushi/ripgrep)

6. [fd](https://github.com/sharkdp/fd)

7. [rust(cargo)](https://www.rust-lang.org/tools/install)

   可能要配置一下的全局变量:`$HOME/.cargo/env`

   有时候慢，那就更换源

   ```txt
   [source.crates-io]
   registry = "https://github.com/rust-lang/crates.io-index"
   replace-with = 'ustc'

   [source.ustc]
   registry = "git://mirrors.ustc.edu.cn/crates.io-index"
   #registry = "https://mirrors.ustc.edu.cn/crates.io-index"

   [http]
   check-revoke = false
   proxy = "127.0.0.1:7890"

   [https]
   proxy = "127.0.0.1:7890"
   ```

8. 需要node > 16.0 和 npm

   安装npm就有node,nodejs,npm了

   主要的代码树什么的，都要，它们是npm install xxx这些。还有copilot也要使用这个，而且必需大于16.0

   [更新nodejs为16.x](https://joshtronic.com/2021/05/09/how-to-install-nodejs-16-on-ubuntu-2004-lts/)

9. [fzf](https://github.com/junegunn/fzf#installation)

   fzf是一款功能强大的模糊查找工具，它提供了快速、交互式的文件和文本查找功能。fzf的全称是"fuzzy finder"，它可以根据输入的模糊关键词来匹配文件和文本，并以交互式的方式展示匹配结果。

   主要配合telescope来使用。

   fzf的插件中，gcc用来build这个插件的。需要环境中有gcc。

   如果是Windows，需要make，不然插件编译不过。

10. gcc g++ make

    treesitter需要这些，不同的代码语言需要不同的，这里暂时这些。

## 一些问题的解决办法

### wsl中实现neovim与系统的剪贴板共享

主要是wsl里面没有剪贴板,需要安装xclip

`yay xclip`

然后在nvim设置:

`vim.opt.clipboard:append("unnamedplus")`
or
`set clipboard=unnamedplus`

### cpp使用msvc

如果直接使用cl.exe进行构建，那么就会失败：

```cpp
The C++ compiler

    "C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.38.33130/bin/Hostx64/x64/cl.exe"

is not able to compile a simple test program.
```

正确的操作应该是在cmd调用：`"C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"`

为了方便使用，这里提供一个pwsh的配置方法：

```pwsh
function vsdev {
    # 定义vcvars64.bat的路径
    $vcvars64Path = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"

    # 检查vcvars64.bat是否存在
    if (Test-Path $vcvars64Path) {
        # 执行vcvars64.bat
        & cmd /c "call `"$vcvars64Path`" && pwsh"
    } else {
        Write-Host "vcvars64.bat 不存在，请检查路径是否正确。"
    }
}
```

在使用的时候，执行一下：`vsdev`，然后在构建的时候选择Ninja的类型的，如果没有自动生成，尝试在构建目录下尝试：`ninja -t compdb > compile_commands.json`。

## 待修正/存在的问题
