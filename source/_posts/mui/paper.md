---
date: 2025-03-18 10:38:41
title: Paper 纸张组件，创建具有层次感和阴影效果的容器组件
tags: [Paper, Mui, 阴影, 层次感]
categories: Mui
description:
cover:
permalink:
---

`Paper` 组件是 `Material UI`（MUI）中用于创建具有*层次感*和*阴影效果*的容器组件。它模拟了物理世界中**纸张**的外观和感觉，通过**阴影**和表面属性来增强视觉层次感。`Paper` 组件通常用于构建`卡片`、`对话框`或其他需要提升视觉效果的表面。

`Paper` 的核心属性有 `elevation`、`variant`、`square`和 `sx`。

## elevation 属性

`elevation`：控制组件的阴影深度，取值范围为 `0` 到 `24`。数值越大，阴影越深，组件看起来越“高”

```tsx
import { Paper, Box, Stack, styled } from "@mui/material";
import { green } from "@mui/material/colors";

const MyPaper = styled(Paper)(({ theme }) => ({
  ...theme.typography.body2,
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
  color: theme.palette.text.secondary,
  height: 60,
  lineHeight: "60px",
  fontSize: "3rem",
}));

function PaperDemo() {
  const arr = Array.from({ length: 24 }, (_, i) => i + 1);

  return (
    <Stack direction="column">
      <Box
        sx={{
          display: "flex",
          flexWrap: "wrap",
          "& > :not(style)": {
            m: 1,
            width: 120,
            height: 120,
            backgroundColor: green[200],
          },
        }}
      >
        {arr.map((_, index) => (
          <MyPaper elevation={index}>{index}</MyPaper>
        ))}
      </Box>
    </Stack>
  );
}

export default PaperDemo;
```

效果：

![Mui Paper 组件](/img/post_img/paper1.png)

## variant 变体

variant：定义组件的样式变体，可选值为 'elevation'（默认，带阴影）和 'outlined'（带边框，无阴影）

```tsx
 <MyPaper variant="outlined" sx={{fontSize:'1rem'}}>outlined</MyPaper>
```

## square

square：布尔值，设置为 true 时，禁用默认的圆角样式

```tsx
<MyPaper square variant="outlined" sx={{fontSize:'1rem'}}>square</MyPaper>
```

## 注意事项

- 阴影层级的使用：合理使用 elevation 属性，避免过度使用高阴影层级。
- 保持风格一致：在同一个应用中保持 Paper 组件的风格一致性。

通过以上方法，你可以轻松地在 MUI 应用中使用 Paper 组件来创建具有层次感和视觉吸引力的界面。
