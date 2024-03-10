---
title: Rust 简单输入输出以及读取文件 - 例子代码
date: 2024-02-21 19:44:02
tags: [Rust]
categories: 编程
description:
cover:
---

在这里分享一个我写的 `Rust` 例子，用到了输入输出和文件读取。

```rust
/// # 学习 Rust 中的标准输入
/// 首先我们要导入 stdin
/// `use std::io::stdin`

use std::io::{self, stdin};
use std::io::prelude::*;
use std::fs::File;

fn main() -> io::Result<()> {
    println!("请输入一些内容个 hello 变量：");
    let mut hello = String::new();
    stdin().read_line(&mut hello)?; // 程序运行到这里会停住等你输入文字

    // 打印 hello 变量
    println!("variable hello>>>: {hello}");

    // 这里多提供一个例子
    // 这个例子是从文件读取内容到变量中去
    let mut f = File::open("foo.txt")?;
    let mut buffer = String::new();

    f.read_to_string(&mut buffer)?;
    // 打印 buffer 里读到的内容
    println!("buffer>>> {buffer}");

    Ok(())
}
```
