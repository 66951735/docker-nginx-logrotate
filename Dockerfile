FROM nginx

RUN mkdir log
# 安装logrotate
RUN apt-get update && apt-get -y install logrotate

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo '$TZ' > /etc/timezone

# 拷贝nginx配置文件到容器内相应目录
COPY nginx.conf /etc/nginx/nginx.conf

# 拷贝logrotate nginx配置文件
COPY kideng-game/logrotate-nginx /etc/logrotate.d/

# 拷贝crontab 定时任务
COPY kideng-game/crontab /etc/

# 开启cron定时任务并以非daemon的方式启动nginx
CMD service cron start && nginx -g 'daemon off;'
