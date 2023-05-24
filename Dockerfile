# 使用基础镜像
FROM nginx

# 复制网页文件到容器中
COPY index.html /app/html/

# 设置Nginx配置
COPY nginx.conf /etc/nginx/conf.d/default.conf
