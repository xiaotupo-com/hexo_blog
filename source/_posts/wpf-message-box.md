---
title: WPF 消息框例子
date: 2024-02-27 12:41:08
tags: [WPF,C#]
categories: 编程
description:
cover:
---

这篇文章记录了 `WPF` 中的 `MessageBox` 的使用，给出了详细的代码例子。

## 消息框

```csharp
namespace Dialogs
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void messageBoxHandle(object sender, RoutedEventArgs e)
        {
            const string title = "黑夜望月";
            switch (textBox.Text)
            {
                case "Ok":
                    var result4 = MessageBox.Show("您购买的图灵电子书仅供您个人使用，未经授权，不得以任何方式复制\r\n和传播本书内容。", title, MessageBoxButton.OK);
                    boxResult.Content = result4;
                    break;
                case "YesNo":
                    var result2 = MessageBox.Show("您购买的图灵电子书仅供您个人使用，未经授权，不得以任何方式复制\r\n和传播本书内容。", title, MessageBoxButton.YesNo);

                    switch (result2)
                    {
                        case MessageBoxResult.Yes:
                            boxResult.Content = "您选择了 Yes";
                            break;
                        case MessageBoxResult.No:
                            boxResult.Content = "您选择了 No";
                            break;
                        default:
                            break;
                    }
                    break;
                case "OKCancel":
                    var result1 = MessageBox.Show("您购买的图灵电子书仅供您个人使用，未经授权，不得以任何方式复制\r\n和传播本书内容。", title, MessageBoxButton.OKCancel);
                    switch (result1)
                    {
                        case MessageBoxResult.OK:
                            boxResult.Content = "您选择了 OK";
                            break;
                        case MessageBoxResult.Cancel:
                            boxResult.Content = "您选择了 Cancel";
                            break;
                        default:
                            break;
                    }
                    break;
                case "YesNoCancel":
                    var result3 = MessageBox.Show("您购买的图灵电子书仅供您个人使用，未经授权，不得以任何方式复制\r\n和传播本书内容。", title, MessageBoxButton.YesNoCancel);
                    switch (result3)
                    {
                        case MessageBoxResult.Yes:
                            boxResult.Content = "您选择了 OK";
                            break;
                        case MessageBoxResult.Cancel:
                            boxResult.Content = "您选择了 Cancel";
                            break;
                        case MessageBoxResult.No:
                            boxResult.Content = "您选择了 No";
                            break;
                        default:
                            break;
                    }
                    break;
            }
        }
    }
}
```

## Yes 消息框

![Yes 消息框](/img/post_img/wpf-message-box-1.png)

## YesNo 消息框

![YesNo 消息框](/img/post_img/wpf-message-box-2.png)

## YesNoCancel 消息框

![YesNoCancel 消息框](/img/post_img/wpf-message-box-3.png)

## OkCancel 消息框

![OkCancel 消息框](/img/post_img/wpf-message-box-4.png)

## 消息框图标

我们可以给消息框提供一个图标选项，图标类如下：

```csharp
public enum MessageBoxImage
{
    //消息框不包含符号。
    None = 0,
    // 显示错误图标
    Error = 16,
    //
    // 摘要:
    //     The message box contains a symbol consisting of a white X in a circle with a
    //     red background.
    Hand = 16,
    //
    // 摘要:
    //     The message box contains a symbol consisting of white X in a circle with a red
    //     background.
    Stop = 16,
    //
    // 摘要:
    //     The message box contains a symbol consisting of a question mark in a circle.
    //     The question mark message icon is no longer recommended because it does not clearly
    //     represent a specific type of message and because the phrasing of a message as
    //     a question could apply to any message type. In addition, users can confuse the
    //     question mark symbol with a help information symbol. Therefore, do not use this
    //     question mark symbol in your message boxes. The system continues to support its
    //     inclusion only for backward compatibility.
    Question = 32, // 问号
    //
    // 摘要:
    //     The message box contains a symbol consisting of an exclamation point in a triangle
    //     with a yellow background.
    Exclamation = 48, // 感叹号
    //
    // 摘要:
    //     The message box contains a symbol consisting of an exclamation point in a triangle
    //     with a yellow background.
    Warning = 48,
    //
    // 摘要:
    //     The message box contains a symbol consisting of a lowercase letter i in a circle.
    Asterisk = 64, // 星号
    //
    // 摘要:
    //     The message box contains a symbol consisting of a lowercase letter i in a circle.
    Information = 64
}
```

例子：

```csharp
var result4 = MessageBox.Show("您购买的图灵电子书仅供您个人使用，未经授权，不得以任何方式复制\r\n和传播本书内容。", title, MessageBoxButton.OK, MessageBoxImage.Question);
```
