---
title: FreeRTOS 创建任务
date: 2024-02-22 22:34:13
tags: [FreeRTOS]
categories: 嵌入式
description:
---

```c
#include "FreeRTOS.h"
#include "task.h"

#define USER_LED_TASK_PRIO       2   /* 定义任务优先级，数字越大优先级越高 */
#define USER_LED_TASK_STACK_SIZE 120 /* 定义任务堆栈大小，单位为：字 */
TaskHandle_t user_led_handle;        /* 定义任务句柄 */

void xtp_create_task(void)
{
    xTaskCreate(
        (TaskFunction_t)led_task,
        (const char *)"led_task",
        (uint16_t)USER_LED_TASK_STACK_SIZE,
        (void *)NULL,
        (UBaseType_t)USER_LED_TASK_PRIO,
        (TaskHandle_t *)user_led_handle);
}
```
