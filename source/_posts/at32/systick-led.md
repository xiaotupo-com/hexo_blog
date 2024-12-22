---
title: AT32 滴答定时器 LED 闪烁
date: 2024-12-19 00:29:06
tags: [AT32, systick, 滴答定时器, LED, 定时器]
categories: 嵌入式
description:
cover:
permalink:
---

在此分享一下 `AT32 Work Bench` 创建的滴答定时器 `LED` 闪灯程序，程序只用到了一个 `LED`，下面是具体的内容。

配置 `system`

![system 配置](/img/post_img/systick-led-01.png)

要把时基源参数中的**延时模式**选择为**中断**，否则的话不会启动中断函数。

```c
// main.c
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

  while(1)
  {
    /* add user code begin 3 */
    if (led_count >= 500) {
      gpio_bits_write(LED2_GPIO_PORT, LED2_PIN, led2_flag = !led2_flag);
      led_count = 0;
    }
    /* add user code end 3 */
  }
}

// at32f435_437_int.c
void SysTick_Handler(void)
{

  led_count++;

  wk_timebase_handler();
}
```

