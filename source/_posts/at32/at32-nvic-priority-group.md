---
title: AT32 配置nvic优先级组
date: 2024-03-12 18:36:54
tags: [AT32,NVIC]
categories: 嵌入式
description:
cover:
permalink:
---

在学习 `At32` 的过程中遇到了`nvic`优先级组，在此做个记录方便以后查阅。`at32`的固件库中 `NVIC` 相关的 `API` 在 `at32f413_misc.c` 文件中。

## nvic_priority_group_type

nvic_priority_group_type 枚举类型，定义了5中分组类型，定义如下：

```c
/**
  * @brief nvic interrupt priority group
  */
typedef enum
{
  NVIC_PRIORITY_GROUP_0                  = ((uint32_t)0x7), /*!< 0 bits for preemption priority, 4 bits for subpriority */
  NVIC_PRIORITY_GROUP_1                  = ((uint32_t)0x6), /*!< 1 bits for preemption priority, 3 bits for subpriority */
  NVIC_PRIORITY_GROUP_2                  = ((uint32_t)0x5), /*!< 2 bits for preemption priority, 2 bits for subpriority */
  NVIC_PRIORITY_GROUP_3                  = ((uint32_t)0x4), /*!< 3 bits for preemption priority, 1 bits for subpriority */
  NVIC_PRIORITY_GROUP_4                  = ((uint32_t)0x3)  /*!< 4 bits for preemption priority, 0 bits for subpriority */
} nvic_priority_group_type;
```

## 配置优先级分组

```c
// 配置 NVIC 分组为 4 位抢占优先级，0位子优先级。
nvic_priority_group_config(NVIC_PRIORITY_GROUP_4);
```
