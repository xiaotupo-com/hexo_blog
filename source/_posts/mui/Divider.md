---
title: Mui 中的 Divider 分割线
date: 2025-03-20 13:50:58
tags:
categories:
description:
cover:
permalink:
---

`Divider` 分隔线组件提供了一条细的、不显眼的线，用于对元素进行分组以加强视觉层次。

下面来看看 `Mui` 官网给的 `Demo` 吧。

```tsx
import { List, ListItem, ListItemText, Divider } from "@mui/material";
import { SxProps } from "@mui/system";

const style: SxProps = {
  py: 0,
  width: "100%",
  maxWidth: 360,
  borderRadius: 2,
  border: "1px solid",
  borderColor: "divider",
  backgroundColor: "background.paper",
};

function DividerDemo() {
  return (
    <List sx={style}>
      <ListItem>
        <ListItemText primary="Full width variant below" />
      </ListItem>
      <Divider component="li" />
      <ListItem>
        <ListItemText primary="Inset variant below" />
      </ListItem>
      <Divider variant="inset" component="li" />
      <ListItem>
        <ListItemText primary="Middle variant below" />
      </ListItem>
      <Divider variant="middle" component="li" />
      <ListItem>
        <ListItemText primary="List item" />
      </ListItem>
    </List>
  );
}

export default DividerDemo;

```

![DividerDemo](/img/post_img/divider.png)
