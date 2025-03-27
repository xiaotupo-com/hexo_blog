---
title: linux tree command
date: 2025-03-27 10:49:23
tags: [Linux, Tree]
categories: Linux
description:
cover:
permalink:
---

在此记录下`Linux` 中的 `tree` 命令笔记。

## 指定输出目录层级 -L

我们可以用 -L 加数字的方式指定 tree 命令只输出指定深度的文件夹。

```bash
tree -L 2
```

只输出2层文件夹的内容。

## 忽略指定文件夹

```bash
tree -I 'node_modules|target|build'
```

我们可以用 `|` 来指定多个要忽略的文件夹。
