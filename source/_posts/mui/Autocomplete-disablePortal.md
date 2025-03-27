---
date: 2025-03-19 12:27:15
title: mui disablePortal 属性的作用
tags: [disablePortal, Autocomplete]
categories: Mui
description:
cover:
permalink:
---

### MUI `disablePortal` 属性的作用

在 MUI（Material UI）中，`disablePortal` 属性用于控制组件是否使用 `Portal` 来渲染其子组件。`Portal` 是一种 React 技术，允许将子组件渲染到父组件之外的 DOM 节点中。默认情况下，某些 MUI 组件（如 `Popper`、`Modal` 和 `Autocomplete`）会使用 `Portal` 来避免渲染问题。

#### **1. `disablePortal` 的作用**

- **默认行为**：当 `disablePortal` 未设置或设置为 `false` 时，组件的子元素将通过 `Portal` 渲染到页面的 `body` 中。
- **禁用行为**：当设置 `disablePortal={true}` 时，子组件将保留在其父组件的 DOM 层级结构中。

#### **2. 使用场景**

- **避免滚动问题**：在某些情况下，使用 `Portal` 可能会导致滚动行为不符合预期。通过设置 `disablePortal={true}`，可以自由实现滚动行为。
- **服务器端渲染**：React 不支持服务器端渲染的 `createPortal()` API。如果需要在服务器端渲染模态框，必须通过 `disablePortal` 禁用 `Portal` 功能。
- **无障碍设计**：在某些无障碍设计场景中，可能需要禁用 `Portal` 来确保焦点管理符合预期。

#### **3. 示例代码**

以下是一些使用 `disablePortal` 的示例代码：

##### **Popper 组件**

```tsx
import React from 'react';
import Popper from '@mui/material/Popper';

const PopperExample = () => {
  const [anchorEl, setAnchorEl] = React.useState<HTMLButtonElement | null>(null);

  const handleClick = (event: React.MouseEvent<HTMLButtonElement>) => {
    setAnchorEl(anchorEl ? null : event.currentTarget);
  };

  return (
    <div>
      <button onClick={handleClick}>Toggle Popper</button>
      <Popper open={Boolean(anchorEl)} anchorEl={anchorEl} disablePortal>
        <div>The content of the Popper.</div>
      </Popper>
    </div>
  );
};

export default PopperExample;
```

##### **Modal 组件**

```tsx
import React from 'react';
import Modal from '@mui/material/Modal';

const ModalExample = () => {
  const [open, setOpen] = React.useState(false);

  const handleOpen = () => setOpen(true);
  const handleClose = () => setOpen(false);

  return (
    <div>
      <button onClick={handleOpen}>Open Modal</button>
      <Modal open={open} onClose={handleClose} disablePortal>
        <div>
          <h2>Server-side modal</h2>
          <p>If you disable JavaScript, you will still see me.</p>
        </div>
      </Modal>
    </div>
  );
};

export default ModalExample;
```

##### **Autocomplete 组件**

```tsx
import React from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';

const AutocompleteExample = () => {
  const options = ['Option 1', 'Option 2', 'Option 3'];

  return (
    <Autocomplete
      disablePortal
      options={options}
      renderInput={(params) => <TextField {...params} label="Select Option" />}
    />
  );
};

export default AutocompleteExample;
```

通过这些示例，你可以看到 `disablePortal` 属性如何在不同组件中使用，以控制子组件的渲染行为。
