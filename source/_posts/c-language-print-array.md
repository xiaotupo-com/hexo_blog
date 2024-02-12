---
title: C语言中打印整型数组的函数实现
date: 2024-02-05 17:42:25
tags: [C语言,数组]
categories: 编程
description:
---

在这里分享出自己写的，用于打印整型数组的`C`函数，把函数写到了 `utils` 文件中，以后可以往里边写一下其他的工具函数。

## utils.h

```c
#ifndef _UTILS_H
#define _UTILS_H

#include <stdio.h>

#define Line(message) printf("-------------------- %s --------------------\n", message)

void print_array_int(int* arr, int size);

#endif /* _UTILS_H */
```

## utils.c

```c
#include "utils.h"
#include <stdio.h>

void print_array_int(int* arr, int size)
{
    for(int i = 0; i < size; i++)
    {
        if (i == (size - 1))
        {
            // 打印最后一个元素，并换行
            printf("%d\n", *(arr++));
        }
        else
        {
            // 打印非最后一个元素，不换行
            printf("%d, ", *(arr++));
        }
    }
}
```
