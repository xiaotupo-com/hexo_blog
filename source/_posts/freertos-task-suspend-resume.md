---
title: FreeRTOS 任务挂起与任务恢复
date: 2024-02-22 22:55:09
tags: [FreeRTOS]
categories: 嵌入式
description:
---

FreeRTOS 的任务有几种状态，并且这几种状态可以相互转换，下面是转换图：

![转换图](/img/post_img/freertos-task-state.png)

任务的4个状态：

- 运行态
- 就绪态，指准备好了，可以随时运行
- 阻塞态
- 挂起态

## 运行态

当任务实际执行时，它被称为处于运行状态。 任务当前正在使用处理器。 如果运行 `RTOS` 的处理器只有一个内核， 那么在任何给定时间内都只能有一个任务处于运行状态。

## 就绪态

准备就绪任务指那些能够执行（它们不处于阻塞或挂起状态）， 但目前没有执行的任务， 因为同等或更高优先级的不同任务已经处于运行状态。

## 阻塞态

如果任务当前正在等待时间或外部事件，则该任务被认为处于阻塞状态。 例如，如果一个任务调用`vTaskDelay()`，它将被阻塞（被置于阻塞状态）， 直到延迟结束-一个时间事件。 任务也可以通过阻塞来等待队列、信号量、事件组、通知或信号量 事件。 处于阻塞状态的任务通常有一个"超时"期， 超时后任务将被超时，并被解除阻塞， 即使该任务所等待的事件没有发生。

`阻塞`状态下的任务不使用任何处理时间，不能 被选择进入运行状态。

## 挂起态 Blocked

与**阻塞**状态下的任务一样， **挂起**状态下的任务不能 被选择进入运行状态，但处于挂起状态的任务 没有超时。 相反，任务只有在分别通过 `vTaskSuspend()` 和 `xTaskResume()` API 调用明确命令时 才会进入或退出挂起状态。

有其他状态变为挂起态只能使用 `vTaskSuspend()`。

恢复挂起态用 `xTaskResume()` 或 `xTaskResumeFromISR()`。

在中断中恢复挂起态的例子：

```c
//外部中断4服务程序
void EXTI4_IRQHandler(void)
{
    BaseType_t YieldRequired;

    //vTaskDelay(10);   //消抖-------//中断函数中不可以使用vTaskDelay()！！！
    if(KEY0==0)  
    {           
        //vTaskResume(Task2Task_Handler);//这里必须使用FromISR版本的！！！  
        YieldRequired=xTaskResumeFromISR(Task2Task_Handler);//恢复任务2
        printf("2 resume\r\n");
        if(YieldRequired==pdTRUE)
        {
            /*如果函数xTaskResumeFromISR()返回值为pdTRUE，那么说明要恢复的这个
            任务的任务优先级等于或者高于正在运行的任务(被中断打断的任务),所以在
            退出中断的时候一定要进行上下文切换！*/
            portYIELD_FROM_ISR(YieldRequired);
        }
    }        
    EXTI_ClearITPendingBit(EXTI_Line4);//清除LINE4上的中断标志位  
}
```
