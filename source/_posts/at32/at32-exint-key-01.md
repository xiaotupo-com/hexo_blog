---
title: AT32 按键例子 - 外部中断模式
date: 2024-12-18 21:44:05
tags: [AT32, 中断, 按键]
categories: 嵌入式
description:
cover:
permalink:
---

今天给大家分享一个基于 `AT32` 单片机的中断按键例子，这个例子通过一个**按键**控制一个 `LED` 的亮灭（**中断**-**上升沿**触发模式）。

原理图：

![/img/post_img/at32-exint-key-01.png](/img/post_img/at32-exint-key-01.png)

我们用的是 `FP11_SW1` ，注意要是能内部上拉电阻，这里我用了 `AT32 Work Bench` 可视化配置工具。

![GPIO 配置](/img/post_img/at32-exint-key-02.png)

中断配置：

![中断配置](/img/post_img/at32-exint-key-03.png)

配置为中断模式并且为上升沿触发，也就是我们在按下按键并且松开时才会触发中断。因为使能了内部上拉电阻，默认为高电平，所以才会在按键松开时触发中断。

![NVIC 配置](/img/post_img/at32-exint-key-04.png)

我们需要勾选 `EXINT15_10_IRQ`，这样会在 `at32f435_437_int.c` 文件中生产 `EXINT15_10_IRQHandler()` 中断函数。

主循环代码：

```c
// main.c
confirm_state led2_flag = TRUE; // 全局变量

while(1)
{
/* add user code begin 3 */
    gpio_bits_write(LED2_GPIO_PORT, LED2_PIN, led2_flag);
/* add user code end 3 */
}
```

EXINT15_10_IRQHandler() 函数：

```c
// at32f435_437_int.c
/**
  * @brief  this function handles EXINT Line [15:10] handler.
  * @param  none
  * @retval none
  */
void EXINT15_10_IRQHandler(void)
{
  /* add user code begin EXINT15_10_IRQ 0 */
	if(exint_interrupt_flag_get(EXINT_LINE_11) != RESET)
	{
		led2_flag = !led2_flag;
		exint_flag_clear(EXINT_LINE_11);
	}
  /* add user code end EXINT15_10_IRQ 0 */
  /* add user code begin EXINT15_10_IRQ 1 */

  /* add user code end EXINT15_10_IRQ 1 */
}
```

这里用的了两个函数 `exint_interrupt_flag_get()` 和 `exint_flag_clear()`，前者为判断中断标志位，后者为清除标志位。

## 结果

将上面代码编译下载到单片机后，发现比较稳定，不需要软件消抖可不会多次触发。

![at32-exint-05](/img/post_img/at32-exint-05.jpg)

至此本实验到此结束！
