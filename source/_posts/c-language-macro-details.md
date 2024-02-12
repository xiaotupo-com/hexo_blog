---
title: C语言宏笔记详情
date: 2024-02-05 20:00:32
tags: [C语言,宏]
categories: 编程
description:
---

宏是`C`语言中的基石，写 `c` 程序就必定会用的宏，所有学习**宏**也是必不可少的。

宏的分类（使用方式）：

- 简单的宏定义（只有宏名）：`#define DEBUG`
- 简单替换：`#define PI 3.1415926`
- 带参数的宏：
  - #define ADD(x,y) ((x) + (y)) 	// 加法运算
  - #define SQRT(x)  ((x) * (x)) 	// 平方运算

## do {} while(0) 语法

在 C 语言 中，使用 do…while 结构来定义宏时，通常是为了确保宏定义中的代码块在使用时可以像一个独立的语句一样被执行。do…while 结构的基本语法如下：

```c
#define MACRO_NAME (arguments...)
do {
  /* 宏定义 */
} while (0)
```

```c
#include <stdio.h>

// 定义一个简单的宏
#define PRIVATE_MESSAGE(msg) do {\
    printf("===============%s===============\n", msg);\
} while(0)

int main() {
    PRIVATE_MESSAGE("PRIVATE MESSAGE");
    return 0;
}
```

输出：

```bash
===============PRIVATE MESSAGE===============
```

## 系统宏

在 C 语言 中，系统预定义的宏提供了有关编译环境、操作系统和其他编译时信息的有用信息。这些宏在编译过程中自动设置，无需用户手动定义。以下是一些常见的系统预定义宏：

- `__DATE__`: 这个宏的替换文本是一个包含编译日期的字符串字面量，日期格式为`“Mmm dd yyyy”`（例如：`“Mar 19 2006”`）1.
- `__TIME__`: 类似于 `__DATE__`，这个宏的替换文本是一个包含编译时间的字符串字面量，时间格式为`“hh:mm:ss”`（例如：`“14:30:45”`）
- `__FILE__`: 这个宏的替换文本是当前源文件的文件名
- `__LINE__`: 这个宏的替换文本是当前源文件中的行号
- `__func__`: 这个宏的替换文本是当前函数的名称（仅在 `C99` 及更高版本中可用）

这些宏可以帮助程序员在编写代码时获取有关编译环境和源文件的信息。例如，你可以在调试时使用 `__FILE__` 和 `__LINE__` 来定位错误。

![C语言系统宏例子](/img/post_img/c_macro_001.png)

输出：

```bash
DATE: Feb 12 2024
TIME: 11:21:27
FILE: E:/work/code/c_dev/c_learn/demos/src/macro_demo.c
LINE: 14
FUNC: system_macro_demo
===============系统宏===============
```

## 宏中的 `#`

```c
#define A(x) #x
#define B(a,b) #a"."#b

printf("%s\n", B(12,23)); // 宏中的 # 的演示
printf("%s\n", A(Hello));
```

以上代码输出：

```bash
12.23
Hello
```

`#` 会把宏传递的参数转换为字符串。

## 宏中的 `##`

```c
#define TEST(x) test##x

static void testA(void)
{
    printf("testA...\n");
}



int main(void)
{
    // 宏中的 ## 演示
    TEST(A)(); // 调用 testA() 函数
}
```

`##` 的作用是连接字符的作用，用于在原有的字符上连接生成新的字符，注意：并不是字符串 "abc" 而是 abc 字符。

## 宏中的 `#@`

在`C`语言的宏中，`#@`的功能是将其后面的宏参数字符化，即在其左右各加上一个单引号。

```c
#define CC(c) #@ c
```

`#@` 只能在 MicroSoft MSVC 中使用，GNU GCC 是不支持的。

## C 语言宏参考

- https://www.cnblogs.com/skyzu2333/p/14888938.html