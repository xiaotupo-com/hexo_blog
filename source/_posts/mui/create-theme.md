---
date: 2025-03-17 10:34:31
title: 创建 theme.tsx 文件并初识MUI的主题
tags: [react, mui, theme]
categories: Mui
description:
cover:
permalink:
---

首先我们在 `src` 目录中创建一个 `theme.tsx` 文件，我们可以在这个文件中创建多个主题，以后这个文件就是我们写主题相关的主要文件。

```tsx
import { createTheme } from "@mui/material";
import { purple } from "@mui/material/colors";

export const navTheme = createTheme({
  components: {
    MuiButton: {
      defaultProps: {
        variant: "outlined",
        color: "success",
        sx: {
          alignItems: "stretch",
          minWidth: "100%",
        },
      },
      styleOverrides: {
        root: {
          // 激活路由的基础样式
          "&.active": {
            color: purple[500], // 使用主题主色
            fontWeight: 600,
            borderBottom: "2px solid",
          },
          // 悬停状态联动
          "&:hover:not(.active)": {
            color: purple[800], // 与主题悬停色一致
          },
        },
      },
    },
  },
});

const theme = createTheme({
  components: {
    MuiButtonBase: {
      defaultProps: {
        disableRipple: true /* 是否仅用按钮点击涟漪效果 */,
      },
    },
    MuiButton: {
      defaultProps: {
        sx: {
          textTransform: "none" /* 自动大写转换 */,
        },
      },
    },
    MuiCard: {
      styleOverrides: {
        root: {
          variants: [
            {
              props: { variant: "outlined" },
              style: {
                borderWidth: "3px",
                p: "20px",
              },
            },
          ],
        },
      },
    },
  },
});

export default theme;
```

我们在 `theme.tsx` 文件中创建了两个主题分别为 `theme` 和 `navTheme` 两个主题，`theme` 用于配置全局样式，该样式用到 `App.tsx` 的根标签。`navTheme` 主题用于 `nav` 页面导航的根标签。

