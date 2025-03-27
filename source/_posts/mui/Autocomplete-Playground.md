---
date: 2025-03-19 12:46:24
title: Autocomplete 练习，各个属性的例子
tags: [mui, Autocomplete, Playground]
categories: Mui
description:
cover:
permalink:
---


## disableCloseOnSelect

`disableCloseOnSelect` 属性可以控制我们在点击列表项后，是否自动关闭下拉列表。默认值为：`false` (点击后会自动关闭)

```tsx
<Stack spacing={1} sx={{ width: 300 }}>
    <Autocomplete
        {...defaultProps}
        id="disable-close-on-select"
        disableCloseOnSelect={false}
        renderInput={(params) => (
        <TextField
            {...params}
            label="disableCloseOnSelect"
            variant="standard"
        />
        )}
    />
</Stack>
```

## clearOnEscape

`clearOnEscape` 属性可以控制我们按键盘 `Esc` 键的时候的行为，默认值为 false(按 `Esc` 键时不会清除当前正在输入的值)。

`clearOnEscape` 为 true 时，我们按 `Esc` 键时会清除当前输入的值。

```tsx
<Autocomplete
    {...defaultProps}
    id="clear-on-escape"
    clearOnEscape={false}
    renderInput={(params) => (
    <TextField {...params} label="clearOnEscape" variant="standard" />
    )}
/>
```

## disableClearable

在 MUI 的 `Autocomplete` 组件中，`disableClearable` 属性用于控制是否显示清除按钮。当设置为 `true` 时，`Autocomplete` 组件不会显示清除按钮，用户无法通过点击清除按钮来清除当前的输入值或选择。

### 示例代码

以下是一个使用 `disableClearable` 属性的 `Autocomplete` 组件示例：

```tsx
import React from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';

const options = [
  { label: 'Option 1', id: 1 },
  { label: 'Option 2', id: 2 },
  { label: 'Option 3', id: 3 },
];

const AutocompleteExample = () => {
  return (
    <Autocomplete
      disableClearable // 禁用清除按钮
      options={options}
      getOptionLabel={(option) => option.label}
      renderInput={(params) => <TextField {...params} label="Select Option" />}
    />
  );
};

export default AutocompleteExample;
```

在这个示例中，`disableClearable` 属性被设置为 `true`，因此用户无法通过点击清除按钮来清除当前的输入值或选择。

通过合理使用 `disableClearable` 属性，可以控制 `Autocomplete` 组件的行为，以满足不同的使用场景和需求。

## openOnFocus

在 MUI 的 `Autocomplete` 组件中，`openOnFocus` 属性的作用是控制当输入框获得焦点时是否自动打开下拉菜单。

- **默认行为**：默认情况下，`openOnFocus` 的值为 `false`，这意味着当输入框获得焦点时，下拉菜单不会自动打开。
- **设置为 `true`**：当将 `openOnFocus` 设置为 `true` 时，输入框获得焦点时会自动打开下拉菜单，方便用户直接查看可用选项。

### 示例代码

以下是一个使用 `openOnFocus` 属性的 `Autocomplete` 组件示例：

```tsx
import React from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';

const options = [
  { label: 'Option 1', id: 1 },
  { label: 'Option 2', id: 2 },
  { label: 'Option 3', id: 3 },
];

const AutocompleteExample = () => {
  return (
    <Autocomplete
      openOnFocus // 当输入框获得焦点时自动打开下拉菜单
      options={options}
      getOptionLabel={(option) => option.label}
      renderInput={(params) => <TextField {...params} label="Select Option" />}
    />
  );
};

export default AutocompleteExample;
```

在这个示例中，当用户点击输入框使其获得焦点时，下拉菜单会自动打开，显示所有可用的选项。

## autoHighlight 属性

在 MUI 的 `Autocomplete` 组件中，`autoHighlight` 属性的作用是控制是否自动高亮显示第一个选项。当设置为 `true` 时，`Autocomplete` 组件会自动高亮显示选项列表中的第一个选项。

### 示例代码

以下是一个使用 `autoHighlight` 属性的 `Autocomplete` 组件示例：

```tsx
import React from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';

const options = [
  { label: 'Option 1', id: 1 },
  { label: 'Option 2', id: 2 },
  { label: 'Option 3', id: 3 },
];

const AutocompleteExample = () => {
  return (
    <Autocomplete
      autoHighlight // 自动高亮显示第一个选项
      options={options}
      getOptionLabel={(option) => option.label}
      renderInput={(params) => <TextField {...params} label="Select Option" />}
    />
  );
};

export default AutocompleteExample;
```

在这个示例中，当用户打开下拉菜单时，第一个选项会被自动高亮显示。

### 注意事项

- **用户体验**：`autoHighlight` 属性可以提升用户体验，因为它减少了用户需要进行的操作步骤。
- **默认行为**：如果未设置 `autoHighlight`，则用户需要手动选择一个选项。

通过合理使用 `autoHighlight` 属性，可以增强 `Autocomplete` 组件的交互性，使其更加用户友好。

## autoSelect

在 MUI 的 `Autocomplete` 组件中，`autoSelect` 属性的作用是控制当用户按下 `Enter` 键时是否自动选择当前高亮的选项。如果设置了 `autoSelect`，按下 `Enter` 键时会自动选择当前高亮的选项，而不仅仅是输入框中的内容。

### **作用**

- **自动选择高亮选项**：当用户按下 `Enter` 键时，自动选择当前高亮的选项，而不是仅仅将输入框中的内容作为选择。
- **增强用户体验**：在某些场景下，用户可能希望直接按下 `Enter` 键来确认选择，而不是手动点击选项。

### **示例代码**

以下是一个使用 `autoSelect` 属性的 `Autocomplete` 组件示例：

```tsx
import React from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';

const options = [
  { label: 'Option 1', id: 1 },
  { label: 'Option 2', id: 2 },
  { label: 'Option 3', id: 3 },
];

const AutocompleteExample = () => {
  return (
    <Autocomplete
      autoSelect // 按下 Enter 键时自动选择当前高亮的选项
      options={options}
      getOptionLabel={(option) => option.label}
      renderInput={(params) => <TextField {...params} label="Select Option" />}
    />
  );
};

export default AutocompleteExample;
```

在这个示例中，当用户按下 `Enter` 键时，`Autocomplete` 组件会自动选择当前高亮的选项，而不是仅仅将输入框中的内容作为选择。

### **注意事项**

- **默认行为**：如果不设置 `autoSelect`，按下 `Enter` 键时，`Autocomplete` 组件会将输入框中的内容作为选择，而不是当前高亮的选项。
- **结合 `autoHighlight`**：通常与 `autoHighlight` 属性一起使用，以确保用户按下 `Enter` 键时，自动选择第一个高亮的选项。

通过合理使用 `autoSelect` 属性，可以增强 `Autocomplete` 组件的交互性，使其更加符合用户的操作习惯。

## disabled

在 MUI 的 `Autocomplete` 组件中，`disabled` 属性用于控制组件是否被禁用。当设置为 `true` 时，`Autocomplete` 组件将被禁用，用户无法与其交互。

### **作用**

- **禁用组件**：当 `disabled` 设置为 `true` 时，`Autocomplete` 组件将不可用，用户无法输入、选择或与组件交互。
- **视觉反馈**：禁用状态的组件通常会显示为灰色或其他视觉上表示不可用的状态，以向用户传达组件当前不可用的信息。
- **表单提交**：在表单中，禁用的组件不会被提交。

### **示例代码**

以下是一个使用 `disabled` 属性的 `Autocomplete` 组件示例：

```tsx
import React from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';

const options = [
  { label: 'Option 1', id: 1 },
  { label: 'Option 2', id: 2 },
  { label: 'Option 3', id: 3 },
];

const AutocompleteExample = () => {
  return (
    <Autocomplete
      disabled={true} // 禁用组件
      options={options}
      getOptionLabel={(option) => option.label}
      renderInput={(params) => <TextField {...params} label="Select Option" />}
    />
  );
};

export default AutocompleteExample;
```

在这个示例中，`disabled` 属性被设置为 `true`，因此 `Autocomplete` 组件被禁用，用户无法与其交互。

### **注意事项**

- **动态控制**：你可以根据应用程序的状态动态设置 `disabled` 属性的值。例如，基于某些条件启用或禁用组件。
- **表单验证**：在表单中，禁用的组件不会被提交。如果你需要在表单提交时验证某些条件，可以动态控制 `disabled` 属性。
- **视觉反馈**：禁用状态的组件通常会显示为灰色或其他视觉上表示不可用的状态。如果你需要自定义禁用状态的样式，可以使用 `sx` 属性或自定义主题。

通过合理使用 `disabled` 属性，可以控制 `Autocomplete` 组件的可用性，以满足不同的使用场景和需求。

## disablePortal

在 MUI 中，`disablePortal` 属性用于控制组件是否使用 Portal 来渲染其子组件。Portal 是一种 React 技术，允许将子组件渲染到父组件之外的 DOM 节点中。默认情况下，某些 MUI 组件（如 `Popper`、`Modal` 和 `Autocomplete`）会使用 Portal 来避免渲染问题。

### **disablePortal 的作用**

- **默认行为**：当 `disablePortal` 未设置或设置为 `false` 时，组件的子元素将通过 Portal 渲染到页面的 `body` 中。
- **禁用行为**：当设置 `disablePortal={true}` 时，子组件将保留在其父组件的 DOM 层级结构中。

### **使用场景**

- **避免滚动问题**：在某些情况下，使用 Portal 可能会导致滚动行为不符合预期。通过设置 `disablePortal={true}`，可以自由实现滚动行为。
- **服务器端渲染**：React 不支持服务器端渲染的 `createPortal()` API。如果需要在服务器端渲染模态框，必须通过 `disablePortal` 禁用 Portal 功能。
- **无障碍设计**：在某些无障碍设计场景中，可能需要禁用 Portal 来确保焦点管理符合预期。

### **示例代码**

以下是一个使用 `disablePortal` 的 `Autocomplete` 组件示例：

```tsx
import React from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';

const options = [
  { label: 'Option 1', id: 1 },
  { label: 'Option 2', id: 2 },
  { label: 'Option 3', id: 3 },
];

const AutocompleteExample = () => {
  return (
    <Autocomplete
      disablePortal // 禁用 Portal 行为
      options={options}
      getOptionLabel={(option) => option.label}
      renderInput={(params) => <TextField {...params} label="Select Option" />}
    />
  );
};

export default AutocompleteExample;
```

在这个示例中，`disablePortal` 属性被设置为 `true`，因此下拉列表将保留在 `Autocomplete` 组件的 DOM 层级结构中。

### **注意事项**

- **滚动行为**：禁用 Portal 可能会影响滚动行为，因为下拉列表不再是独立于父组件的。
- **服务器端渲染**：在服务器端渲染时，禁用 Portal 是必要的，因为 React 不支持服务器端的 `createPortal()` API。
- **无障碍设计**：禁用 Portal 可能会影响焦点管理，需要确保组件的无障碍性。

通过合理使用 `disablePortal` 属性，可以解决一些特定场景下的问题，但需要注意其对滚动行为和无障碍设计的影响。

## blurOnSelect

在 MUI 的 `Autocomplete` 组件中，`blurOnSelect` 属性的作用是控制当用户选择一个选项时，输入框是否失去焦点（即是否触发 `blur` 事件）。当设置为 `true` 时，用户选择选项后，输入框会自动失去焦点。

### **作用**

- **自动失去焦点**：当用户从下拉列表中选择一个选项时，输入框会自动失去焦点。
- **增强用户体验**：在某些场景下，用户选择选项后可能不需要继续编辑输入框，自动失去焦点可以减少用户的操作步骤。

### **示例代码**

以下是一个使用 `blurOnSelect` 属性的 `Autocomplete` 组件示例：

```tsx
import React from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';

const options = [
  { label: 'Option 1', id: 1 },
  { label: 'Option 2', id: 2 },
  { label: 'Option 3', id: 3 },
];

const AutocompleteExample = () => {
  return (
    <Autocomplete
      blurOnSelect // 设置 blurOnSelect 为 true
      options={options}
      getOptionLabel={(option) => option.label}
      renderInput={(params) => <TextField {...params} label="Select Option" />}
    />
  );
};

export default AutocompleteExample;
```

在这个示例中，当用户从下拉列表中选择一个选项时，输入框会自动失去焦点。

### **注意事项**

- **用户体验**：自动失去焦点可能会影响用户体验，尤其是在用户需要快速选择多个选项的场景中。根据具体需求谨慎使用此属性。
- **与其他属性的配合**：`blurOnSelect` 通常与其他属性（如 `clearOnSelect`、`selectOnFocus` 等）配合使用，以实现更复杂的交互逻辑。

通过合理使用 `blurOnSelect` 属性，可以增强 `Autocomplete` 组件的交互性，使其更加符合用户的操作习惯。

## selectOnFocus

在 MUI 的 `Autocomplete` 组件中，`selectOnFocus` 属性的作用是控制当输入框获得焦点时是否自动选中输入框中的内容。当设置为 `true` 时，输入框获得焦点时会自动选中输入框中的内容，方便用户快速编辑或清除输入内容。

### **作用**

- **自动选中内容**：当输入框获得焦点时，自动选中输入框中的内容。
- **增强用户体验**：在某些场景下，用户可能希望在输入框获得焦点时快速编辑或清除内容，自动选中内容可以减少用户的操作步骤。

### **示例代码**

以下是一个使用 `selectOnFocus` 属性的 `Autocomplete` 组件示例：

```tsx
import React from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';

const options = [
  { label: 'Option 1', id: 1 },
  { label: 'Option 2', id: 2 },
  { label: 'Option 3', id: 3 },
];

const AutocompleteExample = () => {
  return (
    <Autocomplete
      selectOnFocus // 设置 selectOnFocus 为 true
      options={options}
      getOptionLabel={(option) => option.label}
      renderInput={(params) => <TextField {...params} label="Select Option" />}
    />
  );
};

export default AutocompleteExample;
```

在这个示例中，当输入框获得焦点时，输入框中的内容会被自动选中。

### **注意事项**

- **用户体验**：自动选中内容可能会影响用户体验，尤其是在用户需要保留输入内容的场景中。根据具体需求谨慎使用此属性。
- **与其他属性的配合**：`selectOnFocus` 通常与其他属性（如 `clearOnSelect`、`blurOnSelect` 等）配合使用，以实现更复杂的交互逻辑。

通过合理使用 `selectOnFocus` 属性，可以增强 `Autocomplete` 组件的交互性，使其更加符合用户的操作习惯。

## freeSolo

将 freeSolo 设置为 true，以便文本框可以包含任意值。
