---
title: C语言动态数组的实现
date: 2024-02-05 18:57:21
tags:
categories:
description:
cover:
---

```c
struct Dyn_arry_t
{
	int* array;
	int capacity;
	int size;
};


void dyn_array_test(void);
struct Dyn_arry_t dyn_array_init(int* array, int size);
```

```c
#include "dyn_array.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "utils.h"

/**
 * @brief 初始化动态数组
 * @param array ：要初始化的数组
 * @param size ：数组的大小
 * @return 返回 my_array, 一个 Dyn_array
*/
struct Dyn_arry_t dyn_array_init(int* array, int size)
{
	// 先创建一个堆栈，用来作为初始动态数组的容器
	int* temp = malloc(sizeof(int) * size * 2);

	if (temp)
	{
		/*for (size_t i = 0; i < size; i++)
		{
			temp[i] = array[i];
		}*/
		memcpy(temp, array, sizeof(int) * size);
		// 这里不能使用 memcpy 来复制 array 到 temp，在这里array 只是一个指针
	}

	struct Dyn_arry_t my_array;
	my_array.array = temp;
	my_array.capacity = size * 2;
	my_array.size = size;

	return my_array;
}

void dyn_array_insert(struct Dyn_arry_t* array, int var)
{
	if ((array->size) < (array->capacity))
	{
		
		array->array[array->size] = var;
		array->size++;
	}
	else
	{
		printf("堆空间已用完\n");
		int* temp = malloc(sizeof(int) * array->capacity * 2);
		
		if (temp)
		{
			array->capacity = array->capacity * 2;
			memcpy(temp, array->array, sizeof(int) * array->size);
			array->array = temp;
			array->array[array->size] = var;
			array->size++;
		}
	}
}

/**
 * @brief	动态数组测试函数
 * @param	none
 * @return	none
*/
void dyn_array_test(void)
{
	Line("动态数组测试");
	struct Dyn_arry_t darray;
	//int iarray[5] = { 1,2,3,4,5 };
	darray = dyn_array_init((int[]) { 1, 2, 3, 4, 5 }, 5);
	printf("动态数组测试\n");
	print_array_int(darray.array, darray.size); // 打印数组
	for (int i = 40; i > 0; i--)
	{
		dyn_array_insert(&darray, i - 6);
	}
	printf("capacity:%d\n", darray.capacity);
	print_array_int(darray.array, darray.size); // 打印数组

	free(darray.array); // 释放堆内存
}
```
