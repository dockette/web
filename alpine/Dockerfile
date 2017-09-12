FROM dockette/edge

MAINTAINER Milan Sulc <sulcmil@gmail.com>

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk upgrade && \
    # DEPENDENCIES #############################################################
    addgroup -S www-data && \
    adduser -D -h /var/www -S -G www-data www-data && \
    # DEPENDENCIES #############################################################
    apk add --update \
        supervisor \
        nginx \
        php7@testing \
        php7-bcmath@testing \
        php7-bz2@testing \
        php7-calendar@testing \
        php7-ctype@testing \
        php7-curl@testing \
        php7-dom@testing \
        php7-fileinfo@testing \
        php7-fpm@testing \
        php7-gd@testing \
        php7-iconv@testing \
        php7-imap@testing \
        php7-intl@testing \
        php7-json@testing \
        php7-mbstring@testing \
        php7-mcrypt@testing \
        php7-mysqli@testing \
        php7-mysqlnd@testing \
        php7-openssl@testing \
        php7-phar@testing \
        php7-pdo@testing \
        php7-pdo_mysql@testing \
        php7-session@testing \
        php7-tokenizer@testing \
        php7-xmlwriter@testing \
        php7-zip@testing \
        php7-xml@testing \
        php7-xmlreader@testing && \
    # NGINX ####################################################################
    rm /etc/nginx/conf.d/default.conf && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    # CLEAN UP #################################################################
    rm -rf /var/cache/apk/*

# PHP
ADD ./php/php-fpm.conf /etc/php7/

# NGINX
ADD ./nginx/nginx.conf /etc/nginx/
ADD ./nginx/mime.types /etc/nginx/
ADD ./nginx/sites.d /etc/nginx/sites.d

# WWW
ADD ./www /srv/www/

# SUPERVISOR
ADD ./supervisor/supervisord.conf /etc/
ADD ./supervisor/services /etc/supervisord.d/

# APPLICATION
WORKDIR /srv

EXPOSE 80 443 9001

CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
