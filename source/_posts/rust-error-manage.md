---
title: Rust 笔记之错误处理
date: 2024-02-22 12:41:08
tags: [Rust]
categories: 编程
description:
cover:
---

```rust

fn result_test(i: i32) -> Result<&'static str, &'static str> {

    if i > 0 {
        Err("Error")
    } else {
        Ok("ok")
    }
}

fn main() {
    println!("Hello, world!");

    let a = result_test(-1);

    assert_eq!(a.is_ok(), true);

    match a {
        Ok(v) => {println!("v: {v}")},
        Err(e) => {println!("e: {e}")}
    }
}
```

https://doc.rust-lang.org/std/result/enum.Result.html
