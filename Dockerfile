FROM alpine:3.10

LABEL Maintainer="Cesar Castro <ccastro@cikume.com>" \
      Description="Generic LAMP Stack"

# Upgrade existing packages in the base image
RUN apk --no-cache upgrade

# Install apache from packages with out caching install files
RUN apk add apache2 curl wget nano php7-apache2 php7-cli php7-phar php7-zlib php7-zip php7-bz2 php7-ctype php7-curl php7-pdo_mysql php7-mysqli php7-json php7-mcrypt php7-xml php7-dom php7-iconv php7-xdebug php7-session php7-intl php7-gd php7-mbstring php7-apcu php7-opcache php7-tokenizer dos2unix bash phpmyadmin supervisor mysql mysql-client

#Setting PHP
COPY config/php.ini /etc/php7/php.ini

#Setting up PhpMyadmin
RUN chown -R apache:apache /etc/phpmyadmin
RUN ln -s /usr/share/webapps/phpmyadmin/ /var/www/localhost/htdocs/phpmyadmin

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Open port for httpd access
EXPOSE 80
EXPOSE 3306

ADD /config/run.sh /scripts/run.sh
RUN dos2unix /scripts/run.sh
RUN chmod 777 /scripts/run.sh

ADD config/entrypoint.sh /etc/entrypoint.sh
RUN dos2unix /etc/entrypoint.sh
RUN chmod 777 /etc/entrypoint.sh

ENTRYPOINT ["/etc/entrypoint.sh"]