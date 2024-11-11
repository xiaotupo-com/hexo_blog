---
title: Hello World
tags: [Hexo, Blog]
cover:
---
该文件是 `hexo` 中默认生成第一篇文章，在此我进行了升级，用该文章记录一些 `hexo` 使用的笔记。

## Quick Start

### Create a new post

``` bash
$ hexo new "My New Post"
```

More info: [Writing](https://hexo.io/docs/writing.html)

### Run server

``` bash
$ hexo server
```

More info: [Server](https://hexo.io/docs/server.html)

### Generate static files

``` bash
$ hexo generate
```

More info: [Generating](https://hexo.io/docs/generating.html)

### Deploy to remote sites

``` bash
$ hexo deploy
```

More info: [Deployment](https://hexo.io/docs/one-command-deployment.html)

## 关于搜索

[https://butterfly.js.org/posts/ceeb73f/#%E6%90%9C%E7%B4%A2](https://butterfly.js.org/posts/ceeb73f/#%E6%90%9C%E7%B4%A2)

我用的`hexo`主题是 `buterfly` 该主题支持几种搜索，这里我选用了最简单的 `local_search` 具体的配置是：

1. 安装 [`hexo-generator-searchdb`](https://github.com/next-theme/hexo-generator-searchdb "hexo-generator-searchdb")

2. 配置主题的 search use 为: `local_search' 代码如下：

```yml
   search:
  # Choose: algolia_search / local_search / docsearch
  # leave it empty if you don't need search
  use: local_search
  placeholder: 搜索

  # Local Search
  local_search:
    # Preload the search data when the page loads.
    preload: false
    # Show top n results per article, show all results by setting to -1
    top_n_per_article: 1
    # Unescape html strings to the readable one.
    unescape: false
    CDN:
```

## 新建文章

```bash
hexo new post -p front-end/nvm-node-manage "用 NVM 管理 npm 和 node 的版本"
```
