---
title: 调试 AT32 ADC时，因采样时间过短导致的ADC值不准问题
date: 2025-11-16 23:12:38
tags: [ADC,采样时间,AT32,调试]
categories: 嵌入式
description:
cover:
permalink:
---

最近在调试我的 NTC 测温板子的时候，遇见了其中一个通道的值老是偏高（ADC值），怎么查也没有查出问题，最后在 chatgpt 上问了一下AI，找到问题了，是因为ADC 采样时间过短导致的。

下面是我最开始的配置：

```c
adc_ordinary_channel_set(ADC1, ADC_CHANNEL_0, 1, ADC_SAMPLETIME_1_5); // adc 采样时间 1.5 个周期
```

把采样时间调到最大：

```c
adc_ordinary_channel_set(ADC1, ADC_CHANNEL_0, 1, ADC_SAMPLETIME_239_5); // adc 采样时间 239.5 个周期
```

改为 `ADC_SAMPLETIME_239_5` 后立马恢复正常了，当然也可以不必使用最大采样周期，我这里对采样速度没什么要求所以就设置为最大采样时间了。

下面是AI给出的一些答案：

> 现象 “只有通道 1 偏大” 在 AT32（其实 STM32/AT32 兼容 ADC 结构）上非常典型，几乎必定是 ADC 采样时间太短导致的，特别是你用的 22k / 68k 电阻分压器（源阻抗远大于 10kΩ）。
> 对 AT32 来说，任何 >4~5kΩ 的源阻抗都会导致 ADC 采集值偏高，尤其在多通道扫描（Sequence Mode）时，第 2 个通道（你的是 Channel1）最容易偏差最大。最后有时间还是要看看用户手册。

采样时间不够为什么会导致测温不准？

> ADC 采样电容来不及充电 → 结果偏低或偏高，取决于前一个通道残留电压

![t4-adc](/img/post_img/t4-adc.jpg)

## 电路优化

我设计的电路中 ntc 热敏电阻并没有增加100nF电容，ntc 作为下电阻需要并联一个 100nF 的电容最好。
