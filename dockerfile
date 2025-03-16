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
