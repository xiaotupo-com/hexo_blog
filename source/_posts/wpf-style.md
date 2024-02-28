---
title: WPF 样式小记
date: 2024-02-28 21:18:46
tags: [WPF,Style]
categories: 编程
description:
---

WPF 中的 Style 和 html 中的 css 是类似的东西，都是定义UI样式，WPF 中的样式可以继承，下面就来了解下 WPF 中的样式使用方法。

## 定义一个简单的样式

这里我们给所有的 Button 定义一个样式，类似与 CSS 中的元素选择器，这里我们选择的元素就是 WPF 中的 Button。

```xml
<Window
    x:Class="Style.MainWindow"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:local="clr-namespace:Style"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    Title="MainWindow"
    Width="800"
    Height="450"
    mc:Ignorable="d">
    <Grid HorizontalAlignment="Center" VerticalAlignment="Center">
        <Grid.RowDefinitions>
            <RowDefinition />
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition />
        </Grid.ColumnDefinitions>
        <Button Content="Ok" />
    </Grid>
</Window>

```

这是没有使用样式的代码，显示效果如下图。

![wpf-style-1](/img/post_img/wpf-style-1.png)

使用样式的代码：

```xml
<Window
    x:Class="Style.MainWindow"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:local="clr-namespace:Style"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    Title="MainWindow"
    Width="800"
    Height="450"
    mc:Ignorable="d">

    <Grid HorizontalAlignment="Center" VerticalAlignment="Center">
        <Grid.Resources>
            <Style TargetType="{x:Type Button}">
                <Setter Property="FontSize" Value="30" />
                <Setter Property="Padding" Value="35,10,35,10" />
                <Setter Property="Foreground">
                    <Setter.Value>
                        <SolidColorBrush Opacity="0.9" Color="#FF109895" />
                    </Setter.Value>
                </Setter>
                <Setter Property="Background">
                    <Setter.Value>
                        <SolidColorBrush Opacity="0.65" Color="#FFF9F9E1" />
                    </Setter.Value>
                </Setter>
            </Style>
        </Grid.Resources>
        <Grid.RowDefinitions>
            <RowDefinition />
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition />
        </Grid.ColumnDefinitions>

        <Button Content="Ok" />
    </Grid>
</Window>
```

![wpf-style-2](/img/post_img/wpf-style-2.png)

样式是要定义到布局元素上的，如：Grid、Window等都可以，这里写到了 Grid.Resources 下，这些样式只对 Grid 下的子元素有效。

这里在 Style 里指定 `TargetType="Button"` 来设置所有 Button 的样式，我们也可以个某个 Button 设置不同的样式，这里会用到继承。

```xml
<Window
    x:Class="Style.MainWindow"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:local="clr-namespace:Style"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    Title="MainWindow"
    Width="800"
    Height="450"
    mc:Ignorable="d">

    <Grid HorizontalAlignment="Center" VerticalAlignment="Center">
        <Grid.Resources>
            <Style x:Key="LeftMarginButtonBase" TargetType="Button">
                <Setter Property="Margin" Value="12,0,0,0" />
                <Setter Property="FontSize" Value="30" />
                <Setter Property="Padding" Value="35,10,35,10" />
            </Style>

            <Style TargetType="{x:Type Button}">
                <Setter Property="FontSize" Value="30" />
                <Setter Property="Padding" Value="35,10,35,10" />
                <Setter Property="Foreground">
                    <Setter.Value>
                        <SolidColorBrush Opacity="0.9" Color="#FF109895" />
                    </Setter.Value>
                </Setter>
                <Setter Property="Background">
                    <Setter.Value>
                        <SolidColorBrush Opacity="0.65" Color="#FFF9F9E1" />
                    </Setter.Value>
                </Setter>
            </Style>


            <Style
                x:Key="RedButton"
                BasedOn="{StaticResource LeftMarginButtonBase}"
                TargetType="Button">
                <Setter Property="Foreground" Value="Red" />
            </Style>

            <Style
                x:Key="YellowButton"
                BasedOn="{StaticResource LeftMarginButtonBase}"
                TargetType="Button">
                <Setter Property="Foreground" Value="Yellow" />
                <Setter Property="Background" Value="Black" />
            </Style>

        </Grid.Resources>
        <Grid.RowDefinitions>
            <RowDefinition />
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition />
        </Grid.ColumnDefinitions>

        <StackPanel Orientation="Horizontal">
            <Button Content="Ok" />
            <Button Content="Ok" Style="{StaticResource RedButton}" />
            <Button Content="Ok" Style="{StaticResource YellowButton}" />
        </StackPanel>

    </Grid>
</Window>

```

![wpf-style-3](/img/post_img/wpf-style-3.png)

这个例子中定义了一个带左侧**Margin**的**Button**基础样式**LeftMarginButtonBase**。


{% note warning %}

`Padding,Margin`

可以整体对左上右下四个方向设置间距，也可以对每个方向设置不同的间距。

```xml
<Setter Property="Margin" Value="12,13,14,15" />
```
- 左：12
- 上：13
- 右：14
- 下：15
{% endnote %}

## 画刷

WPF（Windows Presentation Foundation）中有多种画刷类型，用于填充形状、文本或其他可绘制的元素。以下是几种常见的画刷类型：

### 实心画刷（SolidColorBrush）

实心画刷例子如下：

```xml
<Style TargetType="{x:Type Button}">
    <Setter Property="FontSize" Value="30" />
    <Setter Property="Padding" Value="35,10,35,10" />
    <Setter Property="Foreground">
        <Setter.Value>
            <SolidColorBrush Opacity="0.9" Color="#FF109895" />
        </Setter.Value>
    </Setter>
    <Setter Property="Background">
        <Setter.Value>
            <SolidColorBrush Opacity="0.65" Color="#FFF9F9E1" />
        </Setter.Value>
    </Setter>
</Style>
```

实心画刷可以设置`Color`和`Opacity`两个属性。

### 梯度画刷（GradientBrush）

#### LinearGradientBrush 线性渐变

```xml
<Rectangle>
    <Rectangle.Fill>
        <LinearGradientBrush StartPoint="0,0" EndPoint="1,0">
            <GradientStop Color="Yellow" Offset="0"/>
            <GradientStop Color="Green" Offset="1"/>
        </LinearGradientBrush>
    </Rectangle.Fill>
</Rectangle>
```


### 圆形梯度画刷（RadialGradientBrush）

### 图像画刷（ImageBrush）

### 控件画刷（VisualBrush）

### 自定义画刷（DrawingBrush）
