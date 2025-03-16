---
title: 不同数据库中的 SQL 自增字段类型
date: 2024-11-13 22:17:52
tags: [sql, sqlite, mysql, PostgreSQL]
categories: 数据库
description:
cover:
permalink:
---

有时我们会用到不同的数据库，每种数据库中的 自增字段 SQL 可能不同，在此记录一下不同数据库中的自增字段。

## MySQL 中的自增字段

MySQL 中的自增字段可以用 `AUTO_INCREMENT` 关键字，例子：

```sql
CREATE table student(
    student_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    email VARCHAR(100),
    PRIMARY KEY (student_id)
);
```

## PostgreSQL 中的自增字段

在 `PostgreSQL` 中可以使用 `SERIAL` 或 `BIGSERIAL` 类型来定义自增字段。例子：

```sql
CREATE TABLE student(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);
```

## SQLite 中的自增字段

`SQLite` 中可以用 `AUTOINCREMENT` 来创建自增字段：

```sql
CREATE TABLE student(
    id INT AUTOINCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);
```
