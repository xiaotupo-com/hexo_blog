---
title: AT32 单片机简单按键程序
date: 2024-12-15 19:57:39
tags: [AT32, 单片机, 按键]
categories: 嵌入式
description:
cover:
permalink:
---

今天写了一下简单的按键程序，单片机是 `AT32F437ZGT7` ，按键消抖用的是阻塞延时函数。下面列出代码：

```c
/* add user code begin Header */
/**
 **************************************************************************
 * @file     main.c
 * @brief    main program
 **************************************************************************
 *                       Copyright notice & Disclaimer
 *
 * The software Board Support Package (BSP) that is made available to
 * download from Artery official website is the copyrighted work of Artery.
 * Artery authorizes customers to use, copy, and distribute the BSP
 * software and its related documentation for the purpose of design and
 * development in conjunction with Artery microcontrollers. Use of the
 * software is governed by this copyright notice and the following disclaimer.
 *
 * THIS SOFTWARE IS PROVIDED ON "AS IS" BASIS WITHOUT WARRANTIES,
 * GUARANTEES OR REPRESENTATIONS OF ANY KIND. ARTERY EXPRESSLY DISCLAIMS,
 * TO THE FULLEST EXTENT PERMITTED BY LAW, ALL EXPRESS, IMPLIED OR
 * STATUTORY OR OTHER WARRANTIES, GUARANTEES OR REPRESENTATIONS,
 * INCLUDING BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.
 *
 **************************************************************************
 */
/* add user code end Header */

/* Includes ------------------------------------------------------------------*/
#include "at32f435_437_wk_config.h"
#include "wk_gpio.h"
#include "wk_system.h"

/* private includes ----------------------------------------------------------*/
/* add user code begin private includes */

/* add user code end private includes */

/* private typedef -----------------------------------------------------------*/
/* add user code begin private typedef */

/* add user code end private typedef */

/* private define ------------------------------------------------------------*/
/* add user code begin private define */

/* add user code end private define */

/* private macro -------------------------------------------------------------*/
/* add user code begin private macro */
#define SET_BIT(reg, bit) (reg |= (1 << bit))
#define CLEAR_BIT(reg, bit) (reg &= ~(1 << bit))
/* add user code end private macro */

/* private variables ---------------------------------------------------------*/
/* add user code begin private variables */
confirm_state led2_flag = FALSE;
confirm_state led3_flag = FALSE;
/* add user code end private variables */

/* private function prototypes --------------------------------------------*/
/* add user code begin function prototypes */
static uint8_t key_scan();
/* add user code end function prototypes */

/* private user code ---------------------------------------------------------*/
/* add user code begin 0 */

/* add user code end 0 */

/**
 * @brief main function.
 * @param  none
 * @retval none
 */
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

    /* init gpio function. */
    wk_gpio_config();

    /* add user code begin 2 */

    /* add user code end 2 */

    while (1) {
        /* add user code begin 3 */
        switch (key_scan()) {
        case 0x01:
            gpio_bits_write(LED2_GPIO_PORT, LED2_PIN, led2_flag = !led2_flag);
            break;
        case 0x02:
            gpio_bits_write(LED3_GPIO_PORT, LED3_PIN, led3_flag = !led3_flag);
            break;
        default:
            break;
        }
        /* add user code end 3 */
    }
}

/* add user code begin 4 */
/********************************************************************************
 * @brief 按键扫描，一共两个按键
 * 
 * @return uint8_t 
 ********************************************************************************/
static uint8_t key_scan()
{
    uint8_t result = 0x00;
    flag_status sw1_state, sw2_state;

    // 读取按键状态
    sw1_state = gpio_input_data_bit_read(SW1_GPIO_PORT, SW1_PIN);
    sw2_state = gpio_input_data_bit_read(SW2_GPIO_PORT, SW2_PIN);

    // 判断两个按键中是否有任意一个被按下
    if (!sw1_state | !sw2_state) {
        wk_delay_ms(15); // 延时消抖
        
        // 再次读取按键的状态
        sw1_state = gpio_input_data_bit_read(SW1_GPIO_PORT, SW1_PIN);
        sw2_state = gpio_input_data_bit_read(SW2_GPIO_PORT, SW2_PIN);
        if (!sw1_state) {

            SET_BIT(result, 0);

            while (!gpio_input_data_bit_read(SW1_GPIO_PORT, SW1_PIN)) {
            }
        }
        if (!sw2_state) {
            SET_BIT(result, 1);
            while (!gpio_input_data_bit_read(SW2_GPIO_PORT, SW2_PIN)) {
            }
        }
    }
    return result;
}
/* add user code end 4 */
```
