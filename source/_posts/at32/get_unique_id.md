---
title: AT32 获取芯片唯一ID
date: 2025-01-04 20:51:02
tags: [AT32,唯一ID]
categories: 嵌入式
description:
cover:
permalink:
---

官方文档：

![at32_unique_id](/img/post_img/at32_unique_id.png)

```c
#include "at32f435_437_wk_config.h"
#include "wk_system.h"
#include "wk_usart.h"

#include <stdio.h>

#define STORAGE_INFO    0x1FFFF7E0 // 闪存大小（单位：KByte）
#define UNIQUE_ID       0x1FFFF7E8
#define UNIQUE_ID_0_31  0x1FFFF7E8
#define UNIQUE_ID_32_63 0x1FFFF7EC
#define UNIQUE_ID_64_95 0x1FFFF7F0

struct mcu_info_t {
    uint32_t flash_size;
    uint8_t unique_id[12];
} mcu_info;

void get_mcu_info(void)
{
    mcu_info.flash_size = *(uint32_t *)STORAGE_INFO;

    printf("Flash: %d KByte\n", mcu_info.flash_size);

    for (uint8_t i=0; i<12; i++) {
        mcu_info.unique_id[i] = *(uint8_t*)(UNIQUE_ID+i);
        printf(" %02x", mcu_info.unique_id[i]);
    }
    printf("\n");
}

int main(void)
{
    wk_system_clock_config();

    wk_periph_clock_config();

    wk_nvic_config();

    wk_timebase_init();

    wk_usart1_init();

    get_mcu_info();

    while (1) {
    }
}
```

串口打印结果 (**AT32F437ZGT7**)：

```bash
[2025-01-04 21:04:22.813] Flash: 1024 KByte  
[2025-01-04 21:04:22.813] 41 c0 30 a0 00 c0 f5 04 17 97 20 0e  (96位唯一ID，8x【12字节】)
[2025-01-04 21:04:22.813]
```
