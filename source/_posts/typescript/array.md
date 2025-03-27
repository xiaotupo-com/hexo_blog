---
date: 2025-03-18 11:10:33
title: typescript 数组学习
tags: [javascript, typescript, array, 遍历]
categories: TypeScript
description:
cover:
permalink:
---

javascript 数组学习笔记，再此记录学习中遇到的一些方法。

## Array.from

Array.from() 静态方法从可迭代或类数组对象创建一个新的浅拷贝的数组实例。

我们可以用 `Array.from()` 快速的创建我们需要的数组，下面就来学习以下吧。

```ts
console.log(Array.from("123"))
```

输出：`[ "1", "2", "3" ]`

```ts
console.log(Array.from([1,2,3], (x) => x * 2));
```

输出：`[ 2, 4, 6 ]`
