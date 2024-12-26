---
title: AT32 裸机按键长按操作小例子
date: 2024-12-26 21:45:51
tags: [AT32,按键长按,裸机]
categories: 嵌入式
description:
cover:
permalink:
---

在此分享一个我写的单片机裸机按键长按判断程序，程序功能有一个`按键`和一个`led`，按键默认为低电平，按下时为高电平并且为中断上升沿触发，长按时让蜂鸣器开关状态反转一次，当蜂鸣器开关状态为关闭时，按按键时蜂鸣器不响，当蜂鸣器开关状态为打开时则每按一下按键蜂鸣器就会响一下。

## 类型定义

首先我们要定义一个结构体，这个结构体中包含各个用到的标志位和全局变量。

```c
// sf_types.h
#ifndef _SF_TYPES_H
#define _SF_TYPES_H

#include "at32f435_437.h"

enum buzzer_t { BUZZER_FLAG_OFF, BUZZER_FLAG_ON };

// 系统参数结构体
// 1. 蜂鸣器开关标志位 buzzer_flag 0: 关闭蜂鸣器 1: 开启蜂鸣器
// key_state:
// bit[15] 未使用
// bit[14] 按键中断触发标志位，中断触发时置位该位
// bit[13] 长按标志位：1代表长按，0 清除长按标志位
// bit[12] 是否计数标志位：1 代表开始计数，0 代表停止计数
struct sf_system_t {
    enum buzzer_t buzzer_flag;
    uint16_t key_state;
    uint16_t long_down_count; // 长按计数
    confirm_state led2_flag;
};

extern struct sf_system_t sf_sys;

#endif
```

```c
// sf_types.c
#include "sf_types.h"

// 创建并初始化结构体
struct sf_system_t sf_sys = {
    .buzzer_flag = BUZZER_FLAG_OFF, // 蜂鸣器默认为关闭状态
    .key_state = 0x0000,            // 按键状态默认全零
    .long_down_count = 0            // 长按计数器
};
```

## 外部中断服务函数

```c
void EXINT15_10_IRQHandler(void)
{
  /* add user code begin EXINT15_10_IRQ 0 */
	if (exint_interrupt_flag_get(EXINT_LINE_13) != RESET){
		sf_sys.key_state = SET_BIT(sf_sys.key_state, 14); // 置位中断标志位
		exint_flag_clear(EXINT_LINE_13);
	}
  /* add user code end EXINT15_10_IRQ 0 */
  /* add user code begin EXINT15_10_IRQ 1 */

  /* add user code end EXINT15_10_IRQ 1 */
}
```

## 滴答定时器中断服务函数

```c
void SysTick_Handler(void)
{
  /* add user code begin SysTick_IRQ 0 */

  /* add user code end SysTick_IRQ 0 */

  wk_timebase_handler();

  /* add user code begin SysTick_IRQ 1 */
  if (GET_BIT(sf_sys.key_state, 12)) {
    sf_sys.long_down_count++;
  } else {
    sf_sys.long_down_count = 0;
  }
  
  /* add user code end SysTick_IRQ 1 */
}
```

## 主函数

```c
int main(void)
{
    /* add user code begin 1 */

    /* add user code end 1 */

    /* system clock config. */
    wk_system_clock_config();

    /* config periph clock. */
    wk_periph_clock_config();

    /* nvic config. */
    wk_nvic_config();

    /* timebase config. */
    wk_timebase_init();

    /* usart1 already supports printf. */
    /* init usart1 function. */
    wk_usart1_init();

    /* init exint function. */
    wk_exint_config();

    /* init gpio function. */
    wk_gpio_config();

    /* add user code begin 2 */
    Line();
    printf("初始化结束...\n");
    Line();
    /* add user code end 2 */

    while (1) {
        /* add user code begin 3 */
        // 按键长按判断
        while (GET_BIT(sf_sys.key_state, 14) &&
               (gpio_input_data_bit_read(SW1_GPIO_PORT, SW1_PIN) == SET)) {
            sf_sys.key_state = SET_BIT(sf_sys.key_state, 12); // 置位计数标志位

            // 判断按键按下超过 500ms
            if (sf_sys.long_down_count >= 1000) {
                printf("long_down_count>=500\n");
                sf_sys.key_state = CLEAR_BIT(sf_sys.key_state, 12);
                // 按键长按成功
                sf_sys.key_state = CLEAR_BIT(sf_sys.key_state, 14);
                SELF_LOGICAL_NOT(sf_sys.buzzer_flag); // 反转蜂鸣器的开关状态
                BUZZER_ON();
                wk_delay_ms(5);
                BUZZER_OFF();
                wk_delay_ms(5);
                // 判断蜂鸣器标志位，向串口打印蜂鸣器开启状态
                switch (sf_sys.buzzer_flag) {
                case BUZZER_FLAG_ON:
                    printf("蜂鸣器已打开\n");
                    break;
                case BUZZER_FLAG_OFF:
                    printf("蜂鸣器已关闭\n");
                    break;
                default:
                    break;
                }
            }
        }
        sf_sys.key_state = CLEAR_BIT(sf_sys.key_state, 12); // 清除计数标志位

        // 按键单击操作判断
        if (GET_BIT(sf_sys.key_state, 14) &&
            (gpio_input_data_bit_read(SW1_GPIO_PORT, SW1_PIN) == RESET)) {
            // 判断蜂鸣器标志位
            if (sf_sys.buzzer_flag == BUZZER_FLAG_ON) {
                BUZZER_ON();
                wk_delay_ms(10);
                BUZZER_OFF();
                wk_delay_ms(10);
            }

            SELF_LOGICAL_NOT(sf_sys.led2_flag); // 自身逻辑取反
            gpio_bits_write(LED2_GPIO_PORT, LED2_PIN, sf_sys.led2_flag);
            sf_sys.key_state = CLEAR_BIT(sf_sys.key_state, 14);
        }
        /* add user code end 3 */
    }
}
```

## 程序中用到的宏

```c
#ifndef __UTILS_H
#define __UTILS_H

#define GetArrLen(array)    sizeof(array) / sizeof(array[0])    // 获取数组的长度
#define SET_BIT(num, n)     ((num) | (1 << (n)))								// 设置 num 中的某一位
#define CLEAR_BIT(num, n)   ((num) & ~(1<<(n)))									// 清除 num 中的某一位
#define SELF_LOGICAL_NOT(num) (num = (!(num)))									// 让自身等于自身的逻辑非
#define GET_BIT(num, bit_pos) ((num >> bit_pos) & 1)						// 获取 num 中的某一位

#define Line()  printf("===========================================\n")

#endif
```
