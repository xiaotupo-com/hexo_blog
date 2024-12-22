---
title: MSVC cl 命令使用笔记
date: 2024-12-22 13:05:27
tags: [MSVC, cl命令, C语言]
categories: 编程
description:
cover:
permalink:
---

我们又时不想安装 `Visual Studio` 又想使用 MSVC 编译器则可以安装 [Microsoft C++ 生成工具](https://visualstudio.microsoft.com/zh-hans/visual-cpp-build-tools/ "Microsoft C++ 生成工具")

> Microsoft C++ 生成工具通过可编写脚本的独立安装程序提供 MSVC 工具集，无需使用 Visual Studio。 如果从命令行界面(例如，持续集成工作流中)生成面向 Windows 的 C++ 库和应用程序， 作为持续集成工作流的一部分)。 包括 Visual Studio 2015 Update 3、Visual Studio 2017、Visual Studio 2019 和最新版本 Visual Studio 2022 中提供的工具。

## cl 命令概述

本文主要记录 `cl` 命令的使用，一下是 `cl` 命令的简短概述：

`cl`是微软 Visual C++ 编译器（MSVC）的命令行工具，用于将 C 和 C++ 源程序编译成可执行文件、动态链接库或静态链接库等。以下是对`cl`命令的详细概述：

### 基本语法

- `cl`命令的基本语法格式为：`cl [options] source_file(s) [object_file(s)] [library_file(s)]`。
- `options`是一系列编译选项，用于指定编译的各种参数和行为，如优化级别、警告级别、输出文件类型等。
- `source_file(s)`是要编译的 C 或 C++ 源文件，可以有多个。
- `object_file(s)`是可选的目标文件，通常是由之前的编译过程生成的中间文件。
- `library_file(s)`是可选的库文件，用于链接到最终的可执行文件或库中。

### 主要功能

1. **编译源文件**：将输入的 C 或 C++ 源文件进行编译，生成对应的目标文件（`.obj`）。在这个过程中，编译器会进行词法分析、语法分析、语义分析等操作，将源程序转换为机器可理解的目标代码。
2. **链接目标文件和库文件**：可以将多个目标文件以及所需的库文件进行链接，生成最终的可执行文件（`.exe`）或库文件（`.dll` 或 `.lib`）。链接过程中，会解决各个目标文件之间的符号引用问题，将它们合并成一个完整的可执行程序或库。
3. **生成调试信息**：支持生成调试信息，以便在调试器中进行程序调试。调试信息包含了源程序与目标代码之间的对应关系、变量的类型和位置等，方便开发人员查找和解决程序中的错误。
4. **优化代码**：提供了多种优化选项，能够对生成的目标代码进行优化，提高程序的执行效率和性能。优化操作包括指令调度、寄存器分配、常量折叠等。

### 常用编译选项

- **/EHsc**：指定 C++ 异常处理模型为同步异常处理。
- **/MD**、**/MT**、**/LD**：分别用于指定使用动态运行时库、静态运行时库以及生成动态链接库。
- **/O1**、**/O2**、**/Ox**：不同级别的优化选项，优化程度依次增强。
- **/Wall**：启用所有警告信息，帮助开发人员发现潜在的问题。
- **/I**：指定头文件搜索路径，当编译器在默认路径下找不到头文件时，可以使用该选项指定额外的搜索路径。
- **/D**：定义预处理器宏，相当于在源文件中使用`#define`指令定义宏。

### 与其他工具的配合

- **与链接器（link.exe）配合**：虽然`cl`命令本身可以进行链接操作，但在一些复杂的项目中，可能需要更精细的链接控制，此时可以将`cl`编译生成的目标文件交给`link.exe`进行链接。
- **与调试器（如 Visual Studio Debugger）配合**：生成的带有调试信息的可执行文件或库文件可以在调试器中进行调试，帮助开发人员快速定位和解决程序中的错误。
- **与项目构建系统配合**：在大型项目中，通常会使用项目构建系统如 MSBuild 或 CMake 等，这些系统会在内部调用`cl`命令来完成编译和链接任务。

## 实例

先来一个 `Hello,World!` 程序，这个例子中只有一个 `main.c` 文件：

```c
// main.c
#include <stdio.h>

int main(void)
{
    printf("Hello,World!\n");
}
```

编译该文件使用 `cl main.c`，则会生产 `main.exe` 可执行文件：

```powershell
PS D:\tmp> cl main.c
用于 x64 的 Microsoft (R) C/C++ 优化编译器 19.42.34435 版
版权所有(C) Microsoft Corporation。保留所有权利。

main.c
Microsoft (R) Incremental Linker Version 14.42.34435.0
Copyright (C) Microsoft Corporation.  All rights reserved.

/out:main.exe 
main.obj 
```

### 指定可执行文件名

我们可以用 `cl main.c /link /out:run.exe` 中的 `/link /out:name.exe` 来指定可执行文件的名字。

```powershell
PS D:\tmp> cl main.c /link /out:run.exe
用于 x64 的 Microsoft (R) C/C++ 优化编译器 19.42.34435 版
版权所有(C) Microsoft Corporation。保留所有权利。

main.c
Microsoft (R) Incremental Linker Version 14.42.34435.0
Copyright (C) Microsoft Corporation.  All rights reserved.

/out:main.exe
/out:run.exe
main.obj
PS D:\tmp> .\run.exe
Hello,World!
```

### 编译多个文件

```c
// main.c
#include <stdio.h>

int main(void)
{
    int a = 10, b = 20;

    printf("c: %d\n", add(a, b));
}
```

```c
// add.c
#include "add.h"

int add(int a, int b)
{
    return a+b;
}
```

```c
// add.h
#ifndef _ADD_H
#define _ADD_H

int add(int a, int b);

#endif
```

编译多个文件使用 `cl main.c add.c /link /out:run.exe`，直接在 cl 后面跟多个源文件名即可。

```powershell
PS D:\tmp> cl main.c add.c /link /out:run.exe
用于 x64 的 Microsoft (R) C/C++ 优化编译器 19.42.34435 版
版权所有(C) Microsoft Corporation。保留所有权利。

main.c
add.c
正在生成代码...
Microsoft (R) Incremental Linker Version 14.42.34435.0
Copyright (C) Microsoft Corporation.  All rights reserved.

/out:main.exe 
/out:run.exe 
main.obj 
add.obj 
PS D:\tmp> .\run.exe
c: 30
```

### 用 `/W3` `/W4` 显示更多警告提示

```powershell
PS D:\tmp> cl /W3 main.c add.c /link /out:run.exe
用于 x64 的 Microsoft (R) C/C++ 优化编译器 19.42.34435 版
版权所有(C) Microsoft Corporation。保留所有权利。

main.c
main.c(7): warning C4013: “add”未定义；假设外部返回 int
add.c
正在生成代码...
Microsoft (R) Incremental Linker Version 14.42.34435.0
Copyright (C) Microsoft Corporation.  All rights reserved.

/out:main.exe
/out:run.exe
main.obj
add.obj
```

上面例子提出警告是因为没有在 `main.c` 中包含 `add.h` 头文件。

添加过 `add.h` 头文件后，警告消失了：

```powershell
PS D:\tmp> cl /W3 main.c add.c /link /out:run.exe
用于 x64 的 Microsoft (R) C/C++ 优化编译器 19.42.34435 版
版权所有(C) Microsoft Corporation。保留所有权利。

main.c
add.c
正在生成代码...
Microsoft (R) Incremental Linker Version 14.42.34435.0
Copyright (C) Microsoft Corporation.  All rights reserved.

/out:main.exe
/out:run.exe
main.obj
add.obj
```
