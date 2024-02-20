---
title: C语言字符串处理相关笔记
date: 2024-02-13 13:44:21
tags: [C语言,字符串]
categories: 编程
description:
---

## gets()

函数原型：

```c
char * gets (char *__str);
```

功能：从标准输入读入字符，并保存到`__str`指定的内存空间，直到出现换行符或读到文件结尾为止。

参数：s 字符串首地址。
返回值：
    成功：读入的字符串。
    失败：NULL

例子：

```c
void string_test(void)
{
    char s[100];
    if (gets(s) != NULL) {
        printf("%s\n", s);
    }
}
```

调用该函数会提示警告是危险的函数，可以使用 `fgets()`。

```bash
call to 'gets' declared with attribute warning: Using gets() is always unsafe - use fgets()
```

## fgets()

头文件：`#include<stdio.h>`

函数原型：

```c
char * fgets (char *__restrict__ __s, int __n, FILE *__restrict__ __stream);
```

功能：从`stream`指定的文件内读入字符，保存到`__s`所指定的内存空间，直到出现换行字符、读到文件结尾或是已读了`size - 1`个字符为止，最后会自动加上字符 `\0` 作为字符串结束。

参数：

- __s 字符串
- __n 指定最大读取字符串的长度
- __stream 文件指针，如果读键盘输入的字符串，固定写为stdin

返回值：

- 成功 成功读取的字符串
- 读到文件尾或出错 NULL

描述：

`fgets()`在读取一个用户通过键盘输入的字符串的时候，同时把用户输入的回车也做为字符串的一部分。通过`scanf`和`gets`输入一个字符串的时候，不包含结尾的`\n`，但通过fgets结尾多了`\n`。`fgets()`函数是安全的，不存在缓冲区溢出的问题。

例子：

```c
void string_test(void)
{
    char s[10];
    printf("请输入一些字符串：\n>>>");
    fgets(s, sizeof(s), stdin);
    printf("%s\n", s);
}
```

输出：

```bash
E:\work\code\c_dev\c_learn\build\demos [main ≡ +6 ~11 -5 !]> ."E:/work/code/c_dev/c_learn/build/demos/DEMOS.exe"
请输入一些字符串：
>>>hello,world!
hello,wor
```

可以看到，如果输入的长度大于 10 时，会自动截取。

## puts()

函数原型:

```c
int puts(const char *_Str);
```

在标准输出输出字符串 `_Str`，在在输出完成后自动加一个 `\n`。

返回值：

- 成功 非负值
- 失败 -1

## fputs()

函数原型：

```c
int fputs(const char * __restrict__ _Str,FILE * __restrict__ _File);
```

功能：将`_Str`所指定的字符串写入到`stream`指定的文件中，字符串结束符`\0`不写入文件。

参数：

- _Str 要输出的字符串
- _File 文件指针，如果把字符串输出到屏幕，固定写为`stdout`。

返回值：

- 成功 0
- 失败 -1

注意：`fputs()`是`puts()`的文件操作版本，但`fputs()` 不会自动输出一个`\n`。

例子：

```c
fputs(">>> Hello,World!", stdout);
```

## strlen()

头文件：`#include <string.h>`

函数原型：

```c
size_t strlen(const char *_Str);
```

功能：算指定指定字符串`_Str`的长度，不包含字符串结束符`\0`。

返回值：字符串的长度

例子：

```c
puts("请输入一些内容：");
fputs(">>> ", stdout);
fgets(s, sizeof(s), stdin);
printf(">>> %d\n", strlen(s)); // 获取字符串的长度
```

输出：

```bash
E:\work\code\c_dev\c_learn\build\demos [main ≡ +6 ~11 -5 !]> ."E:/work/code/c_dev/c_learn/build/demos/DEMOS.exe"
请输入一些内容：
>>> hello
>>> 6
```

## strcpy()

头文件：`#include <string.h>`

函数原型：

```c
char *strcpy(char *__restrict__ _Dest, const char *__restrict__ _Source);
```

功能：把`_Source`所指向的字符串复制到`_Dest`所指向的空间中，`\0`也会拷贝过去。

返回值：

- 成功 返回`_Dest`字符串的首地址。
- 失败 NULL

<p class="note note-warning">注意：如果参数<b>_Dest</b>所指的内存空间不够大，可能会造成缓冲溢出的错误情况。</p>

例子：

```c
char s[10];
strcpy(s, "hello");
printf(">>> %s\n", s);
```

## strncpy()

函数原型：

```c
char * strncpy(char * __restrict__ __dst, const char * __restrict__ __src, size_t __n);
```

和 strcpy() 类似，只是多了一个参数。

功能：把`__src`指向字符串的前`n`个字符复制到`__dst`所指向的空间中，是否拷贝结束符看指定的长度是否包含`\0`。

返回值：

- 成功 返回`__dst`字符串的首地址。
- 失败 NULL

<p class="note note-warning">
注意：strncpy() 可能会导致字符串乱码。
</p>

## strcat()

函数原型：

```c
char * strcat(char * __restrict__ __dst, const char * __restrict__ __src);
```

功能：将`__src`字符串连接到`__dst`的尾部，`\0` 也会追加过去。

返回值：

- 成功 返回`__dst`字符串的首地址。
- 失败 NULL

## strncat()

功能：将`__src`字符串前`n`个字符连接到`__dst`的尾部，`\0`也会追加过去。

返回值：

- 成功 返回`__dst`字符串的首地址。
- 失败 NULL

## strcmp()

函数原型：

```c
int __cdecl strcmp(const char *_Str1,const char *_Str2);
```

功能： 比较 _Str1 和 _Str2 的大小，比较的是字符ASCII码大小。

返回值:

- 相等：0
- 大于：>0
- 小于：<0

## strncmp()

函数原型：

```c
int __cdecl strncmp(const char *_Str1,const char *_Str2,size_t _MaxCount);
```

功能： 比较 _Str1 和 _Str2 前n个字符的大小，比较的是字符ASCII码大小。

## sprintf()

函数原型：

```c
int sprintf (char *__stream, const char *__format, ...);
```

功能：根据参数`__format`字符串来转换并格式化数据，然后将结果输出到`__stream`指定的空间中，直到出现字符串结束符 `\0` 为止。


例子：

```c
int x = 10;
int y = 20;
int len = sprintf(s, "x: %d\ny: %d\n", x, y);
printf("len: %d\n", len);
puts(s);
```

## sscanf()

函数原型：

```c
int sscanf(const char *__source, const char *__format, ...);
```

例子：

```c
char src[] = "张三 15";
char name[20];
int age;
sscanf(src, "%s%d", name, &age);
printf("%s\n", name);
printf("%d\n", age);
```

输出：

```bash
E:\work\code\c_dev\c_learn\build\demos [main ≡ +6 ~11 -5 !]> ."E:/work/code/c_dev/c_learn/build/demos/DEMOS.exe"
张三
15
```

参考：

- https://www.cnblogs.com/lyq105/archive/2009/11/28/1612677.html

## strchr()

函数原型：

```c
char * strchr(const char *_Str,int _Val);
```

功能：在字符串`_Str`中查找字母`_Val`出现的位置。

返回值：

- 成功：返回第一次出现的`_Val`地址
- 失败： `NULL`

例子：

```c
char src[] = "hello123_world%你好";
char* new_src = strchr(src, '1');
printf("new_src: %s\n", new_src);
```

输出：

```bash
E:\work\code\c_dev\c_learn\build\demos [main ≡ +6 ~11 -5 !]> ."E:/work/code/c_dev/c_learn/build/demos/DEMOS.exe"
new_src: 123_world%你好
```

## strstr()

函数原型：

```c
char * strstr(const char *_Str,const char *_SubStr);
```

功能：在字符串`_Str`中查找字符串`_SubStr`出现的位置。

参数：

- _Str：源字符串首地址
- _SubStr：匹配字符串首地址

返回值：

成功：返回第一次出现的_SubStr地址
失败： NULL

例子：

```c
char src1[] = "hello123_world%你好";
char src2[] = "o12";
char* new_src = strstr(src1, src2);
printf("new_src: %s\n", new_src);
```

输出：

```bash
E:\work\code\c_dev\c_learn\build\demos [main ≡ +6 ~11 -5 !]> ."E:/work/code/c_dev/c_learn/build/demos/DEMOS.exe"
new_src: o123_world%你好
```
