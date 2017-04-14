#FROM hareemca123/arm-nginx-php
FROM fabioaalves/arm-nginx-php-fpm
ENV php_conf /etc/php5/fpm/php.ini
ENV nginx_conf /etc/nginx/nginx.conf
#COPY default /etc/nginx/conf.d/default.conf
COPY default /etc/nginx/sites-enabled/default
COPY index.php /usr/share/nginx/html/index.php
COPY info.php /usr/share/nginx/html/info.php
RUN rm -rf /usr/share/nginx/html/index.html
#RUN rm -rf /etc/nginx/sites-enabled/default
#RUN sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${php_conf} 
RUN echo "daemon off;" >> ${nginx_conf}
RUN sed -ri 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm.sock/g' /usr/local/etc/php-fpm.conf
RUN sed -i -e 's/;listen.group = nobody/listen.group = app/g' /usr/local/etc/php-fpm.conf
RUN sed -i -e 's/;listen.owner = nobody/listen.owner = app/g' /usr/local/etc/php-fpm.conf
RUN sed -i -e 's/apache/nginx/g' /usr/local/etc/php-fpm.conf
RUN echo "listen.mode = 0777" >> /usr/local/etc/php-fpm.conf
ADD ./phpsysinfo-3.2.6.tar.gz /usr/share/nginx/html/
RUN mkdir -p /run/php && chown -R app:app /var/run/
ADD ./start.sh /opt/start.sh
EXPOSE 80
CMD ["./opt/start.sh"]

