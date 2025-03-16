---
title: FreeRTOS 延时函数
date: 2024-02-23 18:33:30
tags: [FreeRTOS]
categories: 嵌入式
description:
cover:
---

## vTaskDelay()

任务延时函数，把当前任务从运行态（就绪列表），移到延时列表。

参数： xTicksToDelay > 延时的时间长度，单位是系统时钟节拍周期。

如果调用`vTaskDelay()`函数的任务在执行过程中被更高优先级的任务或者中断所打断，那么调用`vTaskDelay()`函数的任务将会受到影响，此时将不能保持一个固定的时间间隔运行。

### 使用例子

```c
vTaskDelay(500/portTICK_PERIOD_MS);
vTaskDelay(200);
```

### 函数定义

```c
#if ( INCLUDE_vTaskDelay == 1 )

    void vTaskDelay( const TickType_t xTicksToDelay )
    {
        BaseType_t xAlreadyYielded = pdFALSE;

        /* A delay time of zero just forces a reschedule. */
        if( xTicksToDelay > ( TickType_t ) 0U )
        {
            configASSERT( uxSchedulerSuspended == 0 );
            vTaskSuspendAll();
            {
                traceTASK_DELAY();

                /* A task that is removed from the event list while the
                 * scheduler is suspended will not get placed in the ready
                 * list or removed from the blocked list until the scheduler
                 * is resumed.
                 *
                 * This task cannot be in an event list as it is the currently
                 * executing task. */
                prvAddCurrentTaskToDelayedList( xTicksToDelay, pdFALSE );
            }
            xAlreadyYielded = xTaskResumeAll();
        }
        else
        {
            mtCOVERAGE_TEST_MARKER();
        }

        /* Force a reschedule if xTaskResumeAll has not already done so, we may
         * have put ourselves to sleep. */
        if( xAlreadyYielded == pdFALSE )
        {
            portYIELD_WITHIN_API();
        }
        else
        {
            mtCOVERAGE_TEST_MARKER();
        }
    }

#endif /* INCLUDE_vTaskDelay */
```

## vTaskDelayUntil()

函数原型：

```c
void vTaskDelayUntil( portTickType *pxPreviousWakeTime, portTickType xTimeIncrement );
```

### 参数 pxPreviousWakeTime

`pxPreviousWakeTime`：指针，指向一个变量，该变量保存任务最后一次解除阻塞的时间。第一次使用前，该变量必须初始化为当前时间。之后这个变量会在`vTaskDelayUntil()`函数内自动更新。

例子：

```c
void test_task(void *pvParameters)
{
    int i = 0;
    static portTickType xLastWakeTime;

    xLastWakeTime = xTaskGetTickCount();

    while(1)
    {
        printf("test_task()");
        sys_led.toggle();
        vTaskDelayUntil(&xLastWakeTime, 100);
    }
    vTaskDelete(NULL);
}
```
