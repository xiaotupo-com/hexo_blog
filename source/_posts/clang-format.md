---
title: clang-format 格式化工具
date: 2024-12-15 13:37:51
tags: [clang-format]
categories: 编程
description:
cover:
permalink:
---

在格式化 `c/c++` 代码时会用到 `clang-format` 这个工具，在此做个简短的记录。

`clang-format` 下载地址：https://llvm.org/builds/

## .clang-format

```clang-format
BasedOnStyle: LLVM # LLVM, Google
IndentWidth: 4
BreakBeforeBraces: Linux
```

- BreakBeforeBraces: Linux
  - 设置为 Linux 则函数的大括号单独一行，if for 等的开始大括号不会单独一行。
- IndentWidth: 4
  - 缩进设为4个空格
- BasedOnStyle
  - 设置基础样式，选择LLVM比较好
