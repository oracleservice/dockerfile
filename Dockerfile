# 使用基础镜像
FROM ubuntu:20.04

# 更新软件包列表并安装必要的软件
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# 复制默认页面文件到容器中
COPY index.html /var/www/html/

# 创建挂载点目录
VOLUME /app/html

# 将挂载点目录与容器内的网页目录进行映射
RUN rm -rf /var/www/html && ln -s /app/html /var/www/html

# 暴露端口
EXPOSE 80

# 启动Nginx服务
CMD ["nginx", "-g", "daemon off;"]
