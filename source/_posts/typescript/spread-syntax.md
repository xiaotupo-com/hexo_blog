---
date: 2025-03-19 11:53:56
title: TypeScript 展开语法 ... 
tags: [typescript, javascript, 展开语法 ]
categories: TypeScript
description:
cover:
permalink:
---

在 TypeScript 中，`...` 语法有多种用途，主要用于扩展运算符（Spread Operator）和剩余参数（Rest Parameters）。以下是这两种用法的详细说明和示例：

### **1. 扩展运算符（Spread Operator）**

扩展运算符用于将数组或对象展开为独立的元素或属性。它在数组和对象操作中非常有用。

#### **1.1 展开数组**

将一个数组的元素展开为独立的元素，可以用于数组拼接、函数参数传递等场景。

##### **示例 1：数组拼接**

```typescript
const array1 = [1, 2, 3];
const array2 = [4, 5, 6];
const combinedArray = [...array1, ...array2];
console.log(combinedArray); // 输出: [1, 2, 3, 4, 5, 6]
```

##### **示例 2：函数参数传递**

```typescript
function sum(a: number, b: number, c: number) {
  return a + b + c;
}

const numbers = [1, 2, 3];
console.log(sum(...numbers)); // 输出: 6
```

#### **1.2 展开对象**

将一个对象的属性展开为独立的键值对，可以用于对象合并、浅拷贝等场景。

##### **示例 1：对象合并**

```typescript
const obj1 = { a: 1, b: 2 };
const obj2 = { c: 3, d: 4 };
const combinedObj = { ...obj1, ...obj2 };
console.log(combinedObj); // 输出: { a: 1, b: 2, c: 3, d: 4 }
```

##### **示例 2：浅拷贝对象**

```typescript
const originalObj = { a: 1, b: 2 };
const copiedObj = { ...originalObj };
console.log(copiedObj); // 输出: { a: 1, b: 2 }
```

### **2. 剩余参数（Rest Parameters）**

剩余参数用于将函数的多个参数收集为一个数组。它在函数中处理可变参数时非常有用。

#### **示例 1：收集多个参数**

```typescript
function multiply(first: number, ...rest: number[]): number {
  return rest.reduce((acc, num) => acc * num, first);
}

console.log(multiply(2, 3, 4)); // 输出: 24
console.log(multiply(5, 6, 7, 8)); // 输出: 1680
```

在这个例子中，`...rest` 收集了除第一个参数外的所有参数，并将它们存储在一个数组中。

`reduce()` 语法：

```ts
reduce(callbackfn: (previousValue: T, currentValue: T, currentIndex: number, array: T[]) => T, initialValue: T): T;
```

### **3. 注意事项**

- **扩展运算符和剩余参数的区别**：
  - 扩展运算符用于展开数组或对象。
  - 剩余参数用于收集函数中的多个参数。

- **类型推断**：
  - 使用扩展运算符时，TypeScript 会根据上下文推断类型。
  - 使用剩余参数时，需要明确指定数组的类型。

### **总结**

- **扩展运算符（Spread Operator）**：
  - 用于展开数组或对象。
  - 常用于数组拼接、函数参数传递、对象合并和浅拷贝。

- **剩余参数（Rest Parameters）**：
  - 用于收集函数中的多个参数。
  - 常用于处理可变参数。

通过合理使用 `...` 语法，可以简化代码并提高可读性。
