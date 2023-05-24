# 使用基础镜像
FROM ubuntu:20.04

# 设置环境变量
ENV DEBIAN_FRONTEND noninteractive

# 更新软件包列表并安装必要的软件
RUN apt-get update \
    && apt-get install -y apache2 mysql-server php libapache2-mod-php php-mysql php-curl php-gd php-intl php-mbstring php-xml php-xmlrpc php-zip curl unzip \
    && rm -rf /var/lib/apt/lists/*

# 安装WordPress
RUN curl -O https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz -C /var/www/html \
    && rm latest.tar.gz

# 设置WordPress配置
COPY wp-config.php /var/www/html/wordpress/

# 设置MySQL数据库
RUN service mysql start \
    && mysql -e "CREATE DATABASE wordpress; GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY 'password'; FLUSH PRIVILEGES;" \
    && service mysql stop

# 设置Apache2
RUN chown -R www-data:www-data /var/www/html \
    && a2enmod rewrite

# 暴露端口
EXPOSE 80

# 启动Apache2服务
CMD ["apache2ctl", "-D", "FOREGROUND"]
