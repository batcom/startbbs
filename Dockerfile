FROM ubuntu:trusty
MAINTAINER Geekwolf
RUN  apt-get -y update && apt-get  -y install mysql-client php5 ImageMagick  apache2 php5-gd php5-mysql
RUN  rm -rf  /var/www/html/*
ADD . /var/www/html
RUN  chown -R www-data:www-data /var/www/html
WORKDIR /var/www/html
RUN echo "ServerName startbbs.daoapp.io">>/etc/apache2/apache2.conf
RUN sed -i "s#'localhost'#getenv("MYSQL_PORT_3306_TCP_ADDR")#g" app/config/database.php && sed -i "s#'startbbs'#getenv("MYSQL_INSTANCE_NAME")#g" app/config/database.php && sed -i "s#'root'#getenv("MYSQL_USERNAME")#g" app/config/database.php && sed -i "s#'123456'#getenv("MYSQL_PASSWORD")#g" app/config/database.php

EXPOSE 80
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
