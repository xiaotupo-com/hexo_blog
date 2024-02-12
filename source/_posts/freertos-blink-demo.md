---
title: FreeRTOS LED闪烁例子
date: 2024-01-30 22:06:19
tags: [FreeRTOS, AT32]
categories: 嵌入式
description:
---

这个例子演示了基于 FreeRTOS 的闪灯程序，这里给出主要代码块。

## main.c

```c++
void vApplicationTickHook(void)
{
  global_num_1++;
  if (global_num_1 >= 500)
  {
    global_num_1 = 0;
    // 给 led_task 任务发送通知
    xTaskNotifyGive(xTaskGetHandle("led_task"));
  }
}
```

## led.c

```c++
/// @brief led FreeRTOS 任务函数
/// @param pvParameters
void led_task(void *pvParameters)
{
    uint32_t ul_notify_value;
    while (1) {
        ul_notify_value = ulTaskNotifyTake(pdTRUE, 0);
        if (ul_notify_value > 0) {
            sys_led.toggle();
        }
    }
}
```
