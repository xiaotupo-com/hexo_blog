---
title: FreeRTOS 按键程序代码笔记
date: 2024-03-07 01:28:37
tags: [FreeRTOS]
categories: 嵌入式
description:
cover:
---

在这里分享一个我写到基于 FreeRTOS 的按键程序，只是自己的一个思路，欢迎讨论。

## 数据结构定义

```c
//
// File: xtp_defines.h
//
#ifndef __XTP_DEFINES_H
#define __XTP_DEFINES_H

#include "at32f413.h"
#include <stdbool.h>
#include <stdio.h>

#define USE_FREERTOS (1) // 1:使用 FreeRTOS 0:不使用 FreeRTOS
#define AT32
#define LED

#if USE_FREERTOS
#include "FreeRTOS.h"
#include "task.h"
#endif

#ifdef LED
#include "led.h"
#endif


#define KEY_PCS 2 // 按键个数

struct key_buffer_t {
    uint16_t buffer;     // 按键 buff
    bool previous_state; // 以前的状态
    uint32_t down_count; // 按下计数（ms）
};

struct key_gpiox_t {
    gpio_type *gpiox;
    uint16_t pin;
};

// 系统参数结构体
struct xtp_system_t {
    int32_t global_num_1;
    int32_t key_count;
    struct key_buffer_t key_buffer[KEY_PCS];
    struct key_gpiox_t key_gpiox[KEY_PCS];
};

extern struct xtp_system_t xtp_system;

#endif /* __XTP_DEFINES_H */
```

```c
//
// xtp_defines.c
//
#include "xtp_defines.h"
#include "xtp_gpio.h"
#include <stdbool.h>
int global_num_1 = 0;

/**
 * @brief 定义系统参数变量 
 * 
 */
struct xtp_system_t xtp_system = {
    .global_num_1 = 0,
    .key_count = 0,
    .key_buffer = {
        {
            .buffer = 0xffff,
            .previous_state = false,
            .down_count = 0,
        },
        {
            .buffer = 0xffff,
            .previous_state = false,
            .down_count = 0
        }
    },
    .key_gpiox = {
        {
            .gpiox = OK_KEY_GPIOX,
            .pin = OK_KEY_PIN
        },
        {
            .gpiox = LEFT_KEY_GPIOX,
            .pin = LEFT_KEY_PIN
        }
    }
};
```

## 主逻辑代码

主逻辑在Tick钩子函数：

```c
void vApplicationTickHook(void)
{
    BaseType_t YieldRequired;
    /**
     * @brief 按键处理
     *
     */
    for (int i = 0; i < KEY_PCS; i++) {
        xtp_system.key_buffer[i].buffer = (xtp_system.key_buffer[i].buffer << 1) |
                                          (!io_get_level(xtp_system.key_gpiox[i].gpiox, xtp_system.key_gpiox[i].pin));

        if (xtp_system.key_buffer[i].buffer == (uint16_t)0x0000) {
            xtp_system.key_buffer[i].previous_state = true;
        } else if (xtp_system.key_buffer[i].buffer == (uint16_t)0xffff && xtp_system.key_buffer[i].previous_state == true) {
            xtp_system.key_buffer[i].previous_state = false;

            // 判断是那个按键按下了
            switch (i) {
                case 0: // OK 按键
                    xTaskNotifyGive(xTaskGetHandle("led_task"));
                    break;
                case 1: // LEFT 按键
                    // vTaskResume(xTaskGetHandle("test_task"));
                    YieldRequired = xTaskResumeFromISR(xTaskGetHandle("test_task")); // 恢复 test_task任务
                    if (YieldRequired == pdTRUE) {
                        /*如果函数xTaskResumeFromISR()返回值为pdTRUE，那么说明要恢复的这个
                        任务的任务优先级等于或者高于正在运行的任务(被中断打断的任务),所以在
                        退出中断的时候一定要进行上下文切换！*/
                        portYIELD_FROM_ISR(YieldRequired);
                    }
                    break;

                default:
                    break;
            }

        } else {
            /* 按键抖动发生了 */
        }
    }
}
```