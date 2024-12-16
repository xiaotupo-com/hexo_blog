---
title: Tauri 从前端访问后端 Rust
date: 2024-12-15 23:33:32
tags: [Rust, Tauri, 前端]
categories: Tauri
description:
cover:
permalink:
---

Tauri 提供了从前端访问后端 rust 函数的功能，这篇文章就来了解下如何使用该功能。

首先看下 rust 后端函数如何定义，以下是 tauri 初始项目中的代码片段：

```rust
// Learn more about Tauri commands at https://tauri.app/develop/calling-rust/
#[tauri::command]
fn greet(name: &str) -> String {
    format!("Hello, {}! You've been greeted from Rust!", name)
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_opener::init())
        .invoke_handler(tauri::generate_handler![greet])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}

```

上面代码中的 `greet()` 就是给前端调用的函数，要让一个函数可以被前端调用需要用到 `command` 宏。

## 前端调用

```typescript
import { ref } from "vue";
import { invoke } from "@tauri-apps/api/core";

const greetMsg = ref("");
const name = ref("");

async function greet() {
  // Learn more about Tauri commands at https://tauri.app/develop/calling-rust/
  greetMsg.value = await invoke("greet", { name: name.value });
}
```

```vue
<template>
  <main class="container">
    <form class="row" @submit.prevent="greet">
      <input id="greet-input" v-model="name" placeholder="Enter a name..." />
      <button type="submit">Greet</button>
    </form>
    <p>{{ greetMsg }}</p>
  </main>
</template>
```
