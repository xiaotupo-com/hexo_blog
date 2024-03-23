---
title: AT32 打印输出 SystemCoreClock 的值
date: 2024-03-11 23:05:23
tags: [AT32,SystemCoreClock]
categories: 嵌入式
description:
cover:
permalink:
---

这里简单演示下打印输出 SystemCoreClock 的值，我用的 MCU 为 at32f413，最大频率为 200MHz。

我的配置：

![at32_system_clock](/img/post_img/at32_system_clock.png)

## 配置代码

时钟的配置可以用 `AT32` 官方提供的时钟配置工具（`AT32_New_Clock_Configuration.exe`）来生成。

```c
void system_clock_config(void)
{
  /* reset crm */
  crm_reset();

  // 使用外部 8MHz 晶振
  crm_clock_source_enable(CRM_CLOCK_SOURCE_HEXT, TRUE);

   /* wait till hext is ready */
  while(crm_hext_stable_wait() == ERROR)
  {
  }

  /* config pll clock resource */
  crm_pll_config(CRM_PLL_SOURCE_HEXT, CRM_PLL_MULT_25, CRM_PLL_OUTPUT_RANGE_GT72MHZ);

  /* enable pll */
  crm_clock_source_enable(CRM_CLOCK_SOURCE_PLL, TRUE);

  /* wait till pll is ready */
  while(crm_flag_get(CRM_PLL_STABLE_FLAG) != SET)
  {
  }

  /* config ahbclk */
  crm_ahb_div_set(CRM_AHB_DIV_1);

  /* config apb2clk, the maximum frequency of APB1/APB2 clock is 100 MHz  */
  crm_apb2_div_set(CRM_APB2_DIV_2);

  /* config apb1clk, the maximum frequency of APB1/APB2 clock is 100 MHz  */
  crm_apb1_div_set(CRM_APB1_DIV_2);

  /* enable auto step mode */
  crm_auto_step_mode_enable(TRUE);

  /* select pll as system clock source */
  crm_sysclk_switch(CRM_SCLK_PLL);

  /* wait till pll is used as system clock source */
  while(crm_sysclk_switch_status_get() != CRM_SCLK_PLL)
  {
  }

  /* disable auto step mode */
  crm_auto_step_mode_enable(FALSE);

  /* update system_core_clock global variable */
  system_core_clock_update();
}
```

`system_core_clock_update();` 函数会更新变量 `system_core_clock` 的值。SystemCoreClock 的值就是 `system_core_clock`。

```c
#define SystemCoreClock                  system_core_clock
```

## printf 输出

```c
int main(void)
{
    system_clock_config();

    xtp_gpio_init();   // 所有 io 初始化
    xtp_usart_init();  // 串口初始化
    xtp_create_task(); // 创建 FreeRTOS 任务
    printf("SystemCoreClock: %d", SystemCoreClock); // 200000000(200MHz)
    /* 开启任务调度器 */
    vTaskStartScheduler();

    while (1) {
    }
}
```
