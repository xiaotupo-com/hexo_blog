---
title: wxWidgets 中文乱码解决办法
date: 2024-06-22 18:45:18
tags: [wxWidgets,中文乱码,Clion,CMake]
categories: Issues 
description:
cover:
permalink:
---

在 Clion 中 wxWidgets 中文乱码的解决办法，解决办法是配置编译器为 UTF-8 选项：

```cmake
# Visual Studio 配置 UTF-8，解决中文乱码问题  
add_compile_options("$<$<C_COMPILER_ID:MSVC>:/utf-8>")  
add_compile_options("$<$<CXX_COMPILER_ID:MSVC>:/utf-8>")
```

![wxWidgets 中文乱码](/img/post_img/wxwidgets_001.png)

- [Possible to force CMake/MSVC to use UTF-8 encoding for source files without a BOM? C4819](https://stackoverflow.com/questions/47690822/possible-to-force-cmake-msvc-to-use-utf-8-encoding-for-source-files-without-a-bo)