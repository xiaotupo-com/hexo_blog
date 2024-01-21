---
title: 我的Vim配置文件
date: 2024-01-13 12:22:06
tags: [Vim]
categories: 编程
description:
---

我的配置文件如下：

```vim
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" base16配色
Plug 'chriskempson/base16-vim'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

Plug 'ycm-core/YouCompleteMe'

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting




set nocompatible "设置和其他Vim改型的不兼容性
set termguicolors
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-solarized-dark "配色设置
set nu
set autoindent "自动缩进
set softtabstop=4
set shiftwidth=4
set tabstop=4
syntax on "语法高亮
filetype indent on "文件类型检查
set laststatus=2 "显示状态栏
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)

set relativenumber "相对行号
set cursorline "高亮当前行
set wildmenu "能够自动补全显示命令行语句，并可利用"Tab"键进行相应的选择
set textwidth=80 "设置行宽
set nowrap "关闭自动折行
set scrolloff=5 "垂直滚动时，光标距离顶部/底部的位置（行）
set wrapmargin=2 "指定折行与编辑器窗口的右边缘之间空出的字符数

set sidescrolloff=15 "水平滚动时，光标距离行首或行尾的位置（字符）,关闭折行时有效
set showmatch "光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个括号
"-----------搜索配置-------------
set hlsearch "搜索时高亮显示匹配结果
set incsearch "输入搜索模式时，每输入一个字符，就自动跳转到第一个匹配的结果
set ignorecase "搜索时忽略大小写
set smartcase
set encoding=utf-8 "使用UTF-8
set undofile "保留撤销历史，文件关闭后在此打开依然可以撤销关闭前的操作
set visualbell "出错时，发出视觉提示
set history=1000 "历史记录次数
set autoread "外部编辑文件时发出提示
set title

if(has("win32"||has("win64")))
        "Windows平台
else
" 其他平台
endif


set autochdir "自动切换工作目录

"配置前缀键
let mapleader = "\<space>"
inoremap jk <Esc>

nnoremap <space> :
nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>1 :b1<CR>
nnoremap <leader>2 :b2<CR>
nnoremap <leader>3 :b3<CR>
nnoremap <leader>4 :b4<CR>
nnoremap <leader>5 :b5<CR>
nnoremap <leader>6 :b6<CR>
nnoremap <leader>7 :b7<CR>
nnoremap <leader>8 :b8<CR>
nnoremap <leader>9 :b9<CR>
nnoremap H ^
nnoremap L $
nnoremap <leader>U gU "转换大写
nnoremap <leader>u gu "转为小写

inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-a> <Home>
inoremap <C-e> <End>

cnoremap <C-j> <t_kd> "切换到下一条命令
cnoremap <C-k> <t_ku> "切换到上一条命令
cnoremap <C-a> <Home> "转到行首
cnoremap <C-e> <End> "转到行尾

" 窗口切换
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

" vim-easy-align 对齐插件配置
nnoremap <leader>ga <Plug>(EasyAlign)

" NerdTree 插件配置
nnoremap <leader>n :NERDTreeToggle<CR>
```

## 超级用户权限编辑

`Vim` 在编辑系统配置文件时经常会使用到，你也许也碰到过对一个文件编辑完成之
后才发现自己没有权限写这个文件。这个时候你只能使用 `q!` 丢弃编辑内容然后重 新以
`sudo` 权限编辑文件。

幸运的是，就连这么蛋疼的问题，`Vim` 也有解决的办法，你可以使用如下命令：

```shell
w !sudo tee >/dev/null %
```
