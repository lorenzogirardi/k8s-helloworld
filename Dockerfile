FROM ajeetraina/centos7-arm
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN yum install -y nginx --nogpgcheck
#RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN yum install -y epel-release --nogpgcheck
RUN yum install -y php-fpm php-xml
ENV php_conf /etc/php.ini
ENV nginx_conf /etc/nginx/nginx.conf
RUN yum clean all
COPY default /etc/nginx/conf.d/default.conf
COPY index.php /usr/share/nginx/html/index.php
COPY info.php /usr/share/nginx/html/info.php
RUN rm -rf /usr/share/nginx/html/index.html
RUN sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${php_conf} && \
    echo "daemon off;" >> ${nginx_conf}
RUN sed -ri 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm\/php-fpm.sock/g' /etc/php-fpm.d/www.conf
RUN sed -i -e 's/;listen.group = nobody/listen.group = nobody/g' /etc/php-fpm.d/www.conf
RUN sed -i -e 's/;listen.owner = nobody/listen.owner = nobody/g' /etc/php-fpm.d/www.conf
RUN sed -i -e 's/apache/nginx/g' /etc/php-fpm.d/www.conf
ADD ./phpsysinfo-3.2.6.tar.gz /usr/share/nginx/html/
RUN mkdir -p /run/php && \
    chown -R nginx:nginx /run/php
ADD ./start.sh /opt/start.sh
EXPOSE 80
CMD ["./opt/start.sh"]

