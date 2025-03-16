---
title: TM3608 可调升压双电源开源项目分享
date: 2024-03-10 22:35:36
tags: [TM3608,双电源,开源项目,升压电源]
categories: 项目
description:
cover:
permalink: /projects/TM3608-double-power/
---

最近做了一个双电源升压模块，可以把一个低的电压升压为正负电压。芯片用的是 `MT3608`，特此分享出来给大家。

供电输入可以选择 USB 也可以选择 6P的排针，通过调节2个电位器可以调整正负输出电压的高低。

## 原理图

![MT3608_01](/img/post_img/MT3608_01.png)

## 成品

![MT3608_02](/img/post_img/MT3608_02.png)

## 力创开源硬件平台

[https://oshwhub.com/zsf90/mt3608_power_double](https://oshwhub.com/zsf90/mt3608_power_double "MT3608_Power_double")
