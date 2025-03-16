---
title: 分享一下我最近学习 wxWidgets 配合 wxFormBuilder开发的简单过程
date: 2024-07-04 23:11:04
tags: [wxWidgets,wxFormBuilder]
categories: 编程
description:
cover:
permalink:
---

在此分享一些我学习 `wxWidgets` 的笔记，这篇文章介绍的是我写的一个简单例子，用到了 `wxFormBuilder` 界面设计工具。

## UI 设计

首先用 `wxFormBuilder` 设计如下图的窗口：

![wxFormBuilder](/img/post_img/wxwidgets-wxformbuild-001.png)

项目树：

![wxwidgets-wxformbuilder-002.png](/img/post_img/wxwidgets-wxformbuilder-002.png)

### bSizer1 属性设置

`bSizer1` 我们只需把方向属性 `orient` 设置为 `wxVERTICAL` 即可，这样 `bSizer1` 就会垂直布局。

![wxwidgets-wxformbuilder-003.png](/img/post_img/wxwidgets-wxformbuilder-003.png)

### 设置两个 spacer 的属性

`UI` 中我用到了两个 `spacer` 控件，控件放入 `bSizer1` 中，并把一个放在最上面另一个放在最下面，这样就会上下两个方向向中间挤压 `bSizer2` 和 `bSizer2，也就实现了我们要的效果。`

### 设置 bSizer2 和 bSizer3

`bSizer2` 和 `bSizer3` 设置成水平方向，并且把 `proportion` 设置为 `0`，这样容器的大小就会紧紧包裹子元素。

`proportion`属性的含义：

当`proportion`设为`0`时，表示该窗口部件的大小是固定的，不会随着父窗口的大小变化而变化。这类窗口部件会保留其最佳大小或指定大小，不会占据额外的空间。

当`proportion`设为正整数时（如1、2、3...），表示该窗口部件可以伸缩，且伸缩的比例相对于同一方向上其他具有正`proportion`值的窗口部件。例如，如果两个窗口部件的`proportion`分别是`1`和`2`，那么当父窗口变大时，后者会比前者增长得更快，两者之间的比例约为`1:2`。

如果多个窗口部件的`proportion`值相同，它们将均等地分享可用的额外空间。

### 设置事件函数

把 8 个按钮的 OnButtonClick 事件都设置为 OnBtnClicked，这样任意一个按钮点击了都会调用这个函数，然后在这个函数中判断是那个按钮按下的。

![wxwidgets-wxformbuilder-004.png](/img/post_img/wxwidgets-wxformbuilder-004.png)

因为要用按钮的 ID 来判断是那个按钮按下的，所以这里我定义了一个自定义的 ID 枚举类：

```c++
//
// Created by freer on 2024/7/4.
//

#ifndef XTP_ID_H
#define XTP_ID_H

// Custom ID
enum class XTPId : int {
    BoxSizer = 10000,
    Btn1,
    Btn2,
    Btn3,
    Btn4,
    Btn5,
    Btn6,
    Btn7,
    Btn8
};
#endif//XTP_ID_H

```

### wxFormBuilder 生成的代码

头文件：

```c++
//
// Created by freer on 2024/7/3.
//

#ifndef BOX_SIZER_DEMO_H
#define BOX_SIZER_DEMO_H

#include <wx/artprov.h>
#include <wx/xrc/xmlres.h>
#include <wx/intl.h>
#include <wx/button.h>
#include <wx/string.h>
#include <wx/bitmap.h>
#include <wx/image.h>
#include <wx/icon.h>
#include <wx/gdicmn.h>
#include <wx/font.h>
#include <wx/colour.h>
#include <wx/settings.h>
#include <wx/sizer.h>
#include <wx/frame.h>

///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
/// Class BoxSizerDemoFrame
///////////////////////////////////////////////////////////////////////////////
class BoxSizerDemoFrame : public wxFrame
{
private:

protected:
    wxButton* m_button1;
    wxButton* m_button2;
    wxButton* m_button3;
    wxButton* m_button4;
    wxButton* m_button5;
    wxButton* m_button6;
    wxButton* m_button7;
    wxButton* m_button8;

    // Virtual event handlers, override them in your derived class
    virtual void OnBtnClicked( wxCommandEvent& event ) { event.Skip(); }


public:

    BoxSizerDemoFrame( wxWindow* parent, wxWindowID id = wxID_ANY, const wxString& title = wxEmptyString, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxSize( 618,203 ), long style = wxDEFAULT_FRAME_STYLE|wxTAB_TRAVERSAL );

    ~BoxSizerDemoFrame();

};




#endif//BOX_SIZER_DEMO_H

```

源文件：

```c++
//
// Created by freer on 2024/7/3.
//
#include "box_sizer_demo.h"
#include "xtp_id.h"

BoxSizerDemoFrame::BoxSizerDemoFrame( wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos, const wxSize& size, long style ) : wxFrame( parent, id, title, pos, size, style )
{
    this->SetSizeHints( wxSize( 500,300 ), wxDefaultSize );

    wxBoxSizer* bSizer1;
    bSizer1 = new wxBoxSizer( wxVERTICAL );


    bSizer1->Add( 0, 0, 1, wxEXPAND, 5 );

    wxBoxSizer* bSizer2;
    bSizer2 = new wxBoxSizer( wxHORIZONTAL );

    m_button1 = new wxButton( this, static_cast<int>(XTPId::Btn1), _("Button1"), wxDefaultPosition, wxDefaultSize, 0 );
    bSizer2->Add( m_button1, 0, wxALL, 5 );

    m_button2 = new wxButton( this, static_cast<int>(XTPId::Btn1), _("Button2"), wxDefaultPosition, wxDefaultSize, 0 );
    bSizer2->Add( m_button2, 0, wxALL, 5 );

    m_button3 = new wxButton( this, static_cast<int>(XTPId::Btn1), _("Button3"), wxDefaultPosition, wxDefaultSize, 0 );
    bSizer2->Add( m_button3, 0, wxALL, 5 );

    m_button4 = new wxButton( this, static_cast<int>(XTPId::Btn1), _("Button4"), wxDefaultPosition, wxDefaultSize, 0 );
    bSizer2->Add( m_button4, 0, wxALL, 5 );


    bSizer1->Add( bSizer2, 0, wxALIGN_CENTER, 5 );

    wxBoxSizer* bSizer3;
    bSizer3 = new wxBoxSizer( wxHORIZONTAL );

    m_button5 = new wxButton( this, static_cast<int>(XTPId::Btn1), _("Button5"), wxDefaultPosition, wxDefaultSize, 0 );
    bSizer3->Add( m_button5, 0, wxALL, 5 );

    m_button6 = new wxButton( this, static_cast<int>(XTPId::Btn1), _("Button6"), wxDefaultPosition, wxDefaultSize, 0 );
    bSizer3->Add( m_button6, 0, wxALL, 5 );

    m_button7 = new wxButton( this, static_cast<int>(XTPId::Btn7), _("Button7"), wxDefaultPosition, wxDefaultSize, 0 );
    bSizer3->Add( m_button7, 0, wxALL, 5 );

    m_button8 = new wxButton( this, static_cast<int>(XTPId::Btn8), _("Button8"), wxDefaultPosition, wxDefaultSize, 0 );
    bSizer3->Add( m_button8, 0, wxALL, 5 );


    bSizer1->Add( bSizer3, 0, wxALIGN_CENTER|wxALL, 5 );


    bSizer1->Add( 0, 0, 1, wxEXPAND, 5 );


    this->SetSizer( bSizer1 );
    this->Layout();

    this->Centre( wxBOTH );

    // Connect Events
    m_button1->Connect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( BoxSizerDemoFrame::OnBtnClicked ), NULL, this );
    m_button2->Connect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( BoxSizerDemoFrame::OnBtnClicked ), NULL, this );
    m_button3->Connect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( BoxSizerDemoFrame::OnBtnClicked ), NULL, this );
    m_button4->Connect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( BoxSizerDemoFrame::OnBtnClicked ), NULL, this );
    m_button5->Connect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( BoxSizerDemoFrame::OnBtnClicked ), NULL, this );
    m_button6->Connect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( BoxSizerDemoFrame::OnBtnClicked ), NULL, this );
    m_button7->Connect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( BoxSizerDemoFrame::OnBtnClicked ), NULL, this );
    m_button8->Connect( wxEVT_COMMAND_BUTTON_CLICKED, wxCommandEventHandler( BoxSizerDemoFrame::OnBtnClicked ), NULL, this );
}

BoxSizerDemoFrame::~BoxSizerDemoFrame()
{
}
```

## 主窗口类

这里开始写主窗口类，另外因为wxFormBuilder 中有个虚函数:

```c++
// Virtual event handlers, override them in your derived class
    virtual void OnBtnClicked( wxCommandEvent& event ) { event.Skip(); }
```

所以我们需要先创建一个继承自 BoxSizerDemoFrame 的类 BoxSizerDemo，BoxSizerDemo 的代码如下：

```c++
class BoxSizerDemo : public BoxSizerDemoFrame
{
    void OnBtnClicked(wxCommandEvent &event) override
    {
        event.Skip();
        switch(event.GetId()) {
            case static_cast<int>(XTPId::Btn1):
                wxMessageBox(wxT("Btn1"), wxT("BoxSizerDemoFrame"), wxOK | wxICON_INFORMATION);
                break;
            case static_cast<int>(XTPId::Btn2):
                wxMessageBox(wxT("Btn2"), wxT("BoxSizerDemoFrame"), wxOK | wxICON_INFORMATION);
                break;
            case static_cast<int>(XTPId::Btn3):
                wxMessageBox(wxT("Btn3"), wxT("BoxSizerDemoFrame"), wxOK | wxICON_INFORMATION);
                break;
            case static_cast<int>(XTPId::Btn4):
                wxMessageBox(wxT("Btn4"), wxT("BoxSizerDemoFrame"), wxOK | wxICON_INFORMATION);
                break;
            case static_cast<int>(XTPId::Btn5):
                wxMessageBox(wxT("Btn5"), wxT("BoxSizerDemoFrame"), wxOK | wxICON_INFORMATION);
                break;
            case static_cast<int>(XTPId::Btn6):
                wxMessageBox(wxT("Btn6"), wxT("BoxSizerDemoFrame"), wxOK | wxICON_INFORMATION);
                break;
            case static_cast<int>(XTPId::Btn7):
                wxMessageBox(wxT("Btn7"), wxT("BoxSizerDemoFrame"), wxOK | wxICON_INFORMATION);
                break;
            case static_cast<int>(XTPId::Btn8):
                wxMessageBox(wxT("Btn8"), wxT("BoxSizerDemoFrame"), wxOK | wxICON_INFORMATION);
                break;
            default:
                wxMessageBox(wxT("Default"), wxT("BoxSizerDemoFrame"), wxOK | wxICON_INFORMATION);
                break;
        }

    }

public:
    BoxSizerDemo(wxWindow *parent, wxWindowID id, const wxString &title) : BoxSizerDemoFrame(parent,id,title)
    {
    }
};
```

### 程序界面

![wxwidgets-wxformbuilder-005.png](/img/post_img/wxwidgets-wxformbuilder-005.png)

### 主窗口代码

头文件：

```c++
// 主窗口
// Created by freer on 2024/7/3.
//

#ifndef MAIN_WINDOWS_H
#define MAIN_WINDOWS_H

#include <wx/wx.h>

class MainWindow : public wxFrame
{
private:
    wxMenu* mFileMenu, *mHelpMenu, *mExamplesMenu;
    wxMenuBar *mMainMenuBar;

private:
    void OnAbout(wxCommandEvent &event);
    void OnMenuItemClicked(wxCommandEvent& event);

public:
    MainWindow();

};
#endif//MAIN_WINDOWS_H
```

源文件：

```c++
MainWindow::MainWindow()
    : wxFrame(nullptr, wxID_ANY, "Examples"),
      mFileMenu(new wxMenu),
      mHelpMenu(new wxMenu),
      mMainMenuBar(new wxMenuBar),
      mExamplesMenu(new wxMenu)
{
    SetMinSize(wxSize(300, 300));// 设置窗口的最小大小

    // 文件菜单
    mFileMenu->Append(wxID_EXIT, "&Exit\tAlt+F4", "Close the application");

    // Examples 菜单
    auto *boxSizerDemoMenuItem = new wxMenuItem(mExamplesMenu, static_cast<int>(XTPId::BoxSizer), "&BoxSizer\tCtrl+b", wxT("打开 BoxSizer 布局例子窗口"));
    mExamplesMenu->Append(boxSizerDemoMenuItem);

    Bind(wxEVT_MENU, &MainWindow::OnMenuItemClicked, this, static_cast<int>(XTPId::BoxSizer));


    // 帮助菜单
    mHelpMenu->Append(wxID_ABOUT, "&About...\tF1", "Show about dialog");
    mHelpMenu->Bind(wxEVT_MENU, &MainWindow::OnAbout, this);

    // 将菜单添加到 MenuBar 中
    mMainMenuBar->Append(mFileMenu, "&File");
    mMainMenuBar->Append(mExamplesMenu, "&Example");
    mMainMenuBar->Append(mHelpMenu, "&Help");

    SetMenuBar(mMainMenuBar);

    CreateStatusBar();

    SetStatusText(_("Ready..."));
}

/**
 * 关于事件
 * @param event
 */
void MainWindow::OnAbout(wxCommandEvent &event)
{
    wxMessageBox(wxT("关于内容"), wxT("关于标题"), wxOK | wxICON_INFORMATION);
}

/**
 * MenuItem 单击事件
 * @param event
 */
void MainWindow::OnMenuItemClicked(wxCommandEvent &event)
{
    if (event.GetId() == static_cast<int>(XTPId::BoxSizer)) {
        auto *boxsizer = new BoxSizerDemo(this, wxID_ANY, wxT("BoxSizerDemo"));
        boxsizer->Show();
    }
}

```