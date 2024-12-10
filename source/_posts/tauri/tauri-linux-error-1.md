---
title: Tauri 在 Linux 下运行出错解决办法
date: 2024-12-10 18:53:45
tags: [Tauri, Linux, Debian]
categories: Tauri
description:
cover:
permalink:
---

```shell
╭─zsf@xiaotupo ~/learn/learn-projects/tauri-learn/learn-01  
╰─➤  pnpm tauri dev                                                                                                                       101 ↵

> learn-01@0.1.0 tauri /home/zsf/learn/learn-projects/tauri-learn/learn-01
> tauri "dev"

    Running BeforeDevCommand (`pnpm dev`)

> learn-01@0.1.0 dev /home/zsf/learn/learn-projects/tauri-learn/learn-01
> vite


  VITE v5.4.11  ready in 259 ms

  ➜  Local:   http://localhost:1420/
    Info Watching /home/zsf/learn/learn-projects/tauri-learn/learn-01/src-tauri for changes...
   Compiling gio v0.18.4
   Compiling cairo-rs v0.18.5
   Compiling atk v0.18.2
   Compiling soup3-sys v0.5.0
   Compiling tokio v1.42.0
   Compiling javascriptcore-rs-sys v1.1.1
   Compiling url v2.5.4
   Compiling dirs v5.0.1
   Compiling string_cache v0.8.7
The following warnings were emitted during compilation:

warning: javascriptcore-rs-sys@1.1.1: 

error: failed to run custom build command for `javascriptcore-rs-sys v1.1.1`

Caused by:
  process didn't exit successfully: `/home/zsf/learn/learn-projects/tauri-learn/learn-01/src-tauri/target/debug/build/javascriptcore-rs-sys-c24e7b65ddaad010/build-script-build` (exit status: 1)
  --- stdout
  cargo:rerun-if-env-changed=JAVASCRIPTCOREGTK_4.1_NO_PKG_CONFIG
  cargo:rerun-if-env-changed=PKG_CONFIG_x86_64-unknown-linux-gnu
  cargo:rerun-if-env-changed=PKG_CONFIG_x86_64_unknown_linux_gnu
  cargo:rerun-if-env-changed=HOST_PKG_CONFIG
  cargo:rerun-if-env-changed=PKG_CONFIG
  cargo:rerun-if-env-changed=PKG_CONFIG_PATH_x86_64-unknown-linux-gnu
  cargo:rerun-if-env-changed=PKG_CONFIG_PATH_x86_64_unknown_linux_gnu
  cargo:rerun-if-env-changed=HOST_PKG_CONFIG_PATH
  cargo:rerun-if-env-changed=PKG_CONFIG_PATH
  cargo:rerun-if-env-changed=PKG_CONFIG_LIBDIR_x86_64-unknown-linux-gnu
  cargo:rerun-if-env-changed=PKG_CONFIG_LIBDIR_x86_64_unknown_linux_gnu
  cargo:rerun-if-env-changed=HOST_PKG_CONFIG_LIBDIR
  cargo:rerun-if-env-changed=PKG_CONFIG_LIBDIR
  cargo:rerun-if-env-changed=PKG_CONFIG_SYSROOT_DIR_x86_64-unknown-linux-gnu
  cargo:rerun-if-env-changed=PKG_CONFIG_SYSROOT_DIR_x86_64_unknown_linux_gnu
  cargo:rerun-if-env-changed=HOST_PKG_CONFIG_SYSROOT_DIR
  cargo:rerun-if-env-changed=PKG_CONFIG_SYSROOT_DIR
  cargo:warning=
  pkg-config exited with status code 1
  > PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 pkg-config --libs --cflags javascriptcoregtk-4.1 javascriptcoregtk-4.1 >= 2.38

  The system library `javascriptcoregtk-4.1` required by crate `javascriptcore-rs-sys` was not found.
  The file `javascriptcoregtk-4.1.pc` needs to be installed and the PKG_CONFIG_PATH environment variable must contain its parent directory.
  The PKG_CONFIG_PATH environment variable is not set.

  HINT: if you have installed the library, try setting PKG_CONFIG_PATH to the directory containing `javascriptcoregtk-4.1.pc`.

warning: build failed, waiting for other jobs to finish...
 ELIFECYCLE  Command failed.
 ELIFECYCLE  Command failed with exit code 101.
```

解决办法：

安装 `libwebkit2gtk-4.1-dev`

```bash
sudo apt install libwebkit2gtk-4.1-dev
```

官方给的针对 `debian` 的依赖库：

```bash
sudo apt update
sudo apt install libwebkit2gtk-4.0-dev \
  build-essential \
  curl \
  wget \
  file \
  libxdo-dev \
  libssl-dev \
  libgtk-3-dev \
  libayatana-appindicator3-dev \
  librsvg2-dev
```

可以看到官方写的是 `libwebkit2gtk-4.0-dev`。
