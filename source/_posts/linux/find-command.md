---
title: Linux find 命令笔记
date: 2024-11-11 23:34:48
tags: [linux, find]
categories: Linux
description: "Linux find 命令笔记"
cover:
permalink:
---

## 一. 基本查找

### 查找指定`目录`中的所有`文件`和`目录`

```bash
find /home/user
sudo find /usr/share
```

### 查找指定目录中的指定文件

查找 `/etc` 目录下的 `hosts` 文件。

```bash
find /etc -name "hosts"
```

```bash
╭─zsf@xiaotupo ~/hexo_blog  ‹main*› 
╰─➤  sudo find /etc -name "hosts"                                                                                                             1 ↵
[sudo] zsf 的密码：
/etc/hosts
/etc/avahi/hosts
```

## 按文件类型查找

1. 查找指定目录中的所有目录：`find /var -type d`
2. 查找指定目录中的所有普通文件：`find /tmp -type f`

## 按文件大小查找

* 查找指定目录下大于某个大小的文件

语法：

```bash
find /path/to/directory -size +n[ckMG]
```

参数：

* `n` 为数字
* `c` 表示字节
* `k` 表示千字节
* `M` 表示兆字节
* `G` 表示吉字节

例子：

在 `/home/user` 目录中查找大于 10Mb 的文件。

```bash
find /home/user -size +10M
```

* 查找指定目录下小于某个大小的文件

和查找指定目录中大于某个大小的文件方法类似，只不过是把 `-size` 后面的 `+` 号换成了 `-` 号而已。

## 按文件修改时间查找

* 查找指定目录中过去 `n` 天内修改过的文件

语法：

```bash
find /path/to/directory -mtime -n
```

例子：

查找过去7天内修改过的文件：

```bash
find /opt -mtime -7
```

* 查找指定目录下过去 `n` 天前修改过的文件

和过去 `n` 天内修改过的文件的查找方法类似，只是把 `-` 号换成了 `+`。

## 逻辑组合查找

* 使用 `-and` 或 `-a` 连接多个条件进行与操作。例如：查找 `/data` 目录下即大于 10MB 又在过去7天内修改过的文件

```bash
find /data -size +10M -a -mtime -7
```

* 使用 `-or` 或 `-o` 连接多个条件进行或操作。例如：查找 `/backup` 目录下文件名包含 `backup` 或者扩展名为 `.bak` 的文件

```bash
find /backup \( -name "*backup*" -o -name "*.bak")
```

## 执行操作

在茶找到文件后，可以使用 `-exec` 选项对查找到的文件执行相应的操作。例如：删除 `/tmp` 目录下所有扩展名为 `.log` 的文件

```bash
find /tmp -name "*.log" -exec rm {} \;
```

这里的 `{}` 表示查找到的文件名，`\;` 是 `-exec` 命令的结束标志。
