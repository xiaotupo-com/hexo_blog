---
title: FreeRTOS 临界区笔记
tags: [FreeRTOS,临界区]
categories: 嵌入式
description:
cover:
---

`FreeRTOS` 临界区描述：临界区也被称为临界段，一旦临界区的代码开始执行，则不允许任何中断打断。为确保临界区代码的执行不被中断，在进入临界段之前须关闭中断，而临界段的代码执行完后，要立即打开中断。

## API 划分

### taskENTER_CRITICAL 和 taskEXIT_CRITICAL

通过调用 `taskENTER_CRITICAL()` 进入临界区，随后 通过调用 `taskEXIT_CRITICAL()` 退出临界区。

### taskENTER_CRITICAL_FROM_ISR
### taskEXIT_CRITICAL_FROM_ISR
### taskDISABLE_INTERRUPTS
### taskENABLE_INTERRUPTS
### vTaskSuspendAll
### xTaskResumeAll

## configMAX_API_CALL_INTERRUPT_PRIORITY

`configMAX_API_CALL_INTERRUPT_PRIORITY` 是 `configMAX_SYSCALL_INTERRUPT_PRIORITY` 的新名称，仅用于新版移植。 这两者是等效的。
