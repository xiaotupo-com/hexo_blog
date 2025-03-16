---
title: 用 Docker 搭建 hexo 博客环境
date: 2025-03-16 06:10:16
tags: [Docker, Hexo]
categories: Docker
description: 用 Docker 搭建 hexo 博客系统，基于 Docker 搭建的好处是不用在我们的操作系统上安装 nodejs。我们只需要 Docker 就可以快速大家一个 hexo环境。我有一个现有的 hexo 项目，在项目的根目录中创建 dockerfile 和 docker-compose.yml 文件，并构建自己的镜像和容器，用容器来运行 hexo 是很好的体验。
cover:
permalink:
---

我的环境是 ubuntu 24.04 + docker，自己不喜欢在系统上安装 nodejs 因为配置麻烦，需要管理环境变量和版本。真的很烦人，但是又想使用 hexo 博客系统，所以我就在想能否在 Docker 容器中运行 hexo 。经过实验是可行的。

在次分享出我的 dockerfile 和 docker-compose.yml 两个文件的内容。

## dockerfile

```dockerfile
# 使用 Node.js 18-slim 作为基础镜像
FROM node:18-slim

# 安装 Git
RUN apt-get update && apt-get install -y git openssh-client

# 设置工作目录
WORKDIR /app

# 安装 Hexo Cli
RUN npm install hexo-cli -g

# 配置 Git 用户信息
ENV GIT_USER="username"
ENV GIT_EMAIL="user@163.com"
ENV GIT_DEFAULT_BRANCH="main"

RUN git config --global user.name ${GIT_USER} && \
    git config --global user.email ${GIT_EMAIL} && \
    git config --global --add safe.directory /app/.deploy_git && \
    git config --global init.defaultBranch ${GIT_DEFAULT_BRANCH}

# 安装 Hexo 依赖
# RUN npm install

# 暴露默认的 Hexo 服务器端口
EXPOSE 4000

# 启动 Hexo 服务器
CMD ["hexo", "server"]
```

## docker-compose.yml

```yml
services:
  hexo:
    build: . # 指定使用当前目录下的 Dockerfile 构建镜像
    container_name: hexo-blog
    image: sf/hexo-blog:latest
    user: "${UID}:${GID}" # 自动匹配宿主机的 UID/GID
    env_file:
      - .env # 显式加载 .env 文件
    ports:
      - "4000:4000"
    volumes:
      - ./:/app # 挂载宿主机的当前目录到容器的 /app 目录
      - /home/zsf/.gitconfig:/home/node/.gitconfig
      - /home/zsf/.ssh/known_hosts:/home/node/.ssh/known_hosts
      - /home/zsf/.ssh:/home/node/.ssh
    restart: always # 总是
    environment:
      - GIT_USER=小土坡
      - GIT_EMAIL="xiaotupo@163.com"
      - GIT_DEFAULT_BRANCH=main
      - HTTP_PROXY="http://192.168.0.102:7897"
      - HTTPS_PROXY="http://192.168.0.102:7897"
```

把 dockerfile 和 docker-compose.yml 文件方的 hexo 项目的根目录，然后运行 `docker compose up` 来开始构建并运行容器。

执行完成后就可以打开 `http://127.0.0.1:4000` 看到自己的博客了。

新建文章：

`docker exec -it hexo-blog bash` ，进入容器后正常执行 hexo 命令即可，还可以 `docker exec -it hexo-blog hexo new post "post name"` 的方式创建文章。

