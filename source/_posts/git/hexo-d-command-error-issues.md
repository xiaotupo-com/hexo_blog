---
title: hexo d 提交报 git 提交错误 Connection closed by xxx.xxx.xxx.xxx port 22
date: 2025-11-14 20:07:56
tags: [git, hexo]
categories: Issues
description: "这篇博客记录了解决 hexo d 命令报 git 提交错误的问题，报错内容如下：Connection closed by 198.18.1.8 port 22 fatal: Could not read from remote repository."
cover:
permalink:
---

今天在执行 `hexo d` 命令来发布博客时遇到了如下报错：

```bash
$ hexo d
INFO  Validating config
INFO
  ===================================================================
      #####  #    # ##### ##### ###### #####  ###### #      #   #
      #    # #    #   #     #   #      #    # #      #       # #
      #####  #    #   #     #   #####  #    # #####  #        #
      #    # #    #   #     #   #      #####  #      #        #
      #    # #    #   #     #   #      #   #  #      #        #
      #####   ####    #     #   ###### #    # #      ######   #
                            5.2.2
  ===================================================================
INFO  Deploying: git
INFO  Clearing .deploy_git folder...
INFO  Copying files from public folder...
INFO  Copying files from extend dirs...
On branch main
nothing to commit, working tree clean
Connection closed by 198.18.1.8 port 22
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
FATAL Something's wrong. Maybe you can find the solution here: https://hexo.io/ocs/troubleshooting.html

```

报错的原因可能是网络封禁了 `22` 端口，可通过 `GitHub` 提供的备用地址 `ssh.github.com:443` 连接：

在 `~/.ssh/` 目录下创建或编辑 `config` 文件（`Windows` 路径为 `C:\Users\你的用户名\.ssh\config`），添加以下内容：

```text
plaintext
Host github.com
  HostName ssh.github.com
  Port 443
  User git
```

保存后执行 `ssh -T git@github.com`，此时会自动通过 `443` 端口连接，若提示 Hi [你的用户名]! You've successfully authenticated... 则说明配置成功。

经过上面配置config 文件后，测试发现 `hexo d` 命令可以顺利发布博客了。
