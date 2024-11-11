---
title: sqlite3 基础语法
date: 2024-11-10 16:43:53
tags: sqlite3
categories: 数据库
description:
cover:
permalink:
---

再此记录以下我学习 `sqlite3` 的一些笔记，主要是心记不好容易忘记。

## 1. 连接或创建数据库

创建和连接数据库用的是一个命令 `sqlite3 name.db` 如果 `name.db` 数据库已存在则连接到该数据库，否则创建该数据库。

也可以直接输入 `sqlite3` 并回车：

```bash
zsf@xiaotupo:~/learn/learn-projects/deno-demo$ sqlite3 
SQLite version 3.40.1 2022-12-28 14:03:47
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> .open test.db
sqlite> SELECT * FROM linux;
Debian|11
Ubuntu|21
sqlite> 
```

因为 `deno-demo` 目录下以及存在了 `test.db` 数据库文件，并且里面有一个数据库 `linux`。所以我们可以执行查询语句：`sqlite> SELECT * FROM linux;`。

## 2. 怎么执行退出 sqlite3 命令

我们进入 `sqlite3` 命令后会看到“Enter ".help" for usage hints.”这样的一些信息，可以看到 `.help` ，这就是 `sqlite3` 中的命令格式。

1. .help 获取帮助信息，很有用。
2. .exit 或 .quit 退出 `sqlite3`

## 3. 查看表结构

在此直接给出例子：

```sqlite
sqlite> .schema linux
CREATE TABLE linux(name string,version int);
```

## 4. 查看当前打开的数据库文件的位置

```sqlite
sqlite> .database
main: /home/zsf/learn/learn-projects/deno-demo/test.db r/w
```

## 5. 创建一个表

```sqlite
sqlite> CREATE TABLE phone(brand string, model string, price DECIMAL(10,2));
```

## 6. 插入数据

```sqlite
sqlite> INSERT INTO phone(brand, model, price) VALUES ("小米", "小米13 Max", 3200.01);
sqlite> SELECT * FROM phone ;
小米|小米13 Max|3200.01
```

如果要为表中的每个字段都插入数据，并且安装表中字段的顺序插入，则可以省略列名：

```sqlite
sqlite> INSERT INTO phone VALUES ("小米", "小米13 Max", 3200.01);
```

## 7. 查询表中的数据

### 1. 基础语法

查找表 `linux` 中的所有数据。

```sqlite
sqlite> SELECT * FROM linux;
Debian|11
Ubuntu|21
```

### 2. 查询指定字段

之查询制定字段：

```sqlite
sqlite> SELECT model, price FROM phone ;
小米13 Max|3200.01
华为16Pro|4889.32
```

### 3. 条件查询
