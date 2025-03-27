---
date: 2025-03-16 12:30:59
title: 安装常用 react 相关库
tags: [react, unocss, mui]
categories: React
description:
cover:
permalink:
---

在这里记录以下安装常用库的过程。

## 安装 UnoCSS 和预设

```bash
bun add -D unocss
bun add -D @unocss/preset-uno
```

`@unocss/preset-uno` 是 `unocss` 的默认预设，官网地址：[Uno preset](https://unocss.dev/presets/uno)

### 配置

将 `virtual:uno.css` 添加到主入口文件 `main.tsx` 中。

```tsx
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import 'virtual:uno.css'; // 加入

import App from './App.tsx'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>,
)
```

### 创建 uno.config.ts

创建 `unocss` 配置文件 `uno.config.ts`。

```ts
import { defineConfig } from 'unocss'

export default defineConfig({
  // ...UnoCSS options
  // 自定义规则
  rules: [
    ['sft-text-red', { color: 'red' }],

  ],
  shortcuts: [
    ['btn', 'py-2 px-4 rounded-md bg-primary text-green hover:bg-primary']
  ]
})
```

### 更新 vite.config.ts 文件

```ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react-swc'
import UnoCSS from 'unocss/vite'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    react(),
    UnoCSS()
  ],
})
```
