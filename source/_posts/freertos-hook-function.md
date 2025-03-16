---
title: FreeRTOS钩子函数
date: 2024-03-07 00:46:59
tags: [FreeRTOS]
categories: [嵌入式]
description:
cover:
---

FreeRTOS 中的钩子函数和中断的回调函数很像，钩子函数的名字是固定的，在特定事件下会自动执行响应名字的钩子函数，并且钩子函数是可剪裁的，在 FreeRTOSConfig.h中配置是否启用特定的钩子函数。

## vApplicationTickHook

节拍中断可以选择是否回调一个钩子函数，这个钩子函数允许实现一些周期性的功能。

使用节拍中断钩子函数，需要将 `configUSE_TICK_HOOK`设置为1，同时钩子函数申明为如下原型：

`void vApplicationTickHook( void )`

这个钩子函数必须很短且占用堆栈空间很少，因为这是在中断中调用的函数，同时，只能调用以**FromISR**结尾的**API**函数。

