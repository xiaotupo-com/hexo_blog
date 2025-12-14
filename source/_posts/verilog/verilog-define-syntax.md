---
title: Verilog define 预处理语法
date: 2025-12-14 14:46:04
tags: [define, 反引号语法, verilog预处理]
categories: Verilog
description:
cover:
permalink:
---

学习 `Verilog` 的时候发现了一些以 "\`"开关的代码，还有类似C语言中的 `#define` 这样的宏定义语法，但是 `verilog` 中这样的"\`define COUNTER_WIDTH 25" 。

看下下面代码：

```verilog
`define COUNTER_WIDTH 25
`define COUNTER_MAX 25_000_000
```

首先 \` 反引号是 `Verilog/SystemVerilog` 的预处理指令前缀。

verilog 中类似的符号：

```verilog
' 单引号（bit-select / 数值宽度）
" 字符串
` 反引号（预处理前缀）
```

在 Verilog/SystemVerilog 中，凡是以 \` 开头的关键字都是预处理指令。

就像 C 语言里的：

```c
#define
#include
#ifdef
```

## \`define 是干什么的？

```verilog
`define COUNTER_WIDTH 25
```

作用：

> 在编译之前，把代码里出现的 `COUNTER_WIDTH 全部替换成 25。

这是纯文本替换，不是变量、不是参数、不是寄存器。

### 使用方式

```verilog
reg [`COUNTER_WIDTH-1:0] cnt;
```

编译前等价于：

```verilog
reg [24:0] cnt;
```

## 和 parameter 的重要区别

|项目|\`define|parameter|
|---|---|---|
|作用阶段|编译前文本替换|综合/实例化阶段|
|是否有作用域|全局（容易冲突）|模块作用域|
|是否可被覆盖|不可|实例化可覆盖|
|是否推荐工程使用|少量用|强烈推荐|

不推荐：

```verilog
`define WIDTH 8
```

推荐：

```verilog
parameter WIDTH = 8;
```

## 推荐使用的场景

在某些场景推荐使用宏指令：

定义编译开关

```verilog
`define SIMULATION

`ifdef SIMULATION
    initial begin
        // 仿真专用代码
    end
`endif
```

定义全局常量（如总线宽度）

```verilog
`define DATA_WIDTH 16
```

条件编译（跨平台）

```verilog
`ifdef ALTERA
`elsif XILINX
`endif
```

最后总结：能用 `parameter` 的地方就不要用 `define`。
