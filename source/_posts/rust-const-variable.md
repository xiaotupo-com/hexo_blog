---
title: Rust 笔记之常量与变量
date: 2024-02-21 19:52:37
tags: [Rust]
categories: 编程
description:
cover:
---

Rust 中变量和常量的概念，变量分为可变变量和不可变变量，常量用 const 定义。

```rust
fn main() {
    println!("/////////////////////////////////////////");
    println!("==============Hello, world!==============");
    println!("/////////////////////////////////////////");

    let x = 5; // x 不可变，自动类型推导为 i32
    let y: f64 = 12.325; // y 不可变，显式指定类型为 f64, 带小数点的默认自动为 f64
    let mut z: f64; // z 可变，值可变，在定义时不给初始化则必须指定变量的类型

    println!("x: {x}");
    println!("y: {y}");
    z = 100.0;
    z = (x as f64) + y + z;
    println!("z: {z}");

    let x = "Hello"; // 再次定义变量 x，在 Rust 中称为隐藏（Shadowing）
    println!("x: {x}");

    const PI: f64 = 3.14; // const 常量的定义必须显式指定类型。
    println!("PI: {PI}");

}

```
