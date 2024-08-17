---
title: SSD1306 初始化遇到屏幕花屏的调试笔记
date: 2024-06-15 19:29:22
tags:
categories:
description:
cover:
permalink:
---

在调试 SSD1306 驱动 0.96寸 OLED 时，遇到了在初始化完成后全屏点亮时花屏，最后发现去掉这两行命令后回复正常：

```c
// 设置起始页地址，假设从第0页开始
sendCommand(0x22);// 设置页地址指令
sendCommand(0x00);// 设置起始页地址，这里设为第0页
// 注意：对于128x64的SSD1306，页地址范围是0到7（共8页）
```

花屏图片：

![SSD1306 初始化遇到屏幕花屏的调试笔记](/img/post_img/ssd1306-init-01.jpg)
