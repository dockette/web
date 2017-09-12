FROM dockette/jessie

MAINTAINER Milan Sulc <sulcmil@gmail.com>

# PHP
ENV PHP_MODS_DIR=/etc/php/7.1/mods-available
ENV PHP_CLI_DIR=/etc/php/7.1/cli/
ENV PHP_CLI_CONF_DIR=${PHP_CLI_DIR}/conf.d
ENV PHP_CGI_DIR=/etc/php/7.1/cgi/
ENV PHP_CGI_CONF_DIR=${PHP_CGI_DIR}/conf.d
ENV PHP_FPM_DIR=/etc/php/7.1/fpm/
ENV PHP_FPM_CONF_DIR=${PHP_FPM_DIR}/conf.d
ENV PHP_FPM_POOL_DIR=${PHP_FPM_DIR}/pool.d
ENV TZ=Europe/Prague

# INSTALLATION
RUN apt update && apt dist-upgrade -y && \
    # DEPENDENCIES #############################################################
    apt install -y wget curl apt-transport-https ca-certificates && \
    # PHP DEB.SURY.CZ ##########################################################
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ jessie main" > /etc/apt/sources.list.d/php.list && \
    wget -O- http://nginx.org/keys/nginx_signing.key | apt-key add - && \
    echo "deb http://nginx.org/packages/debian/ jessie nginx" > /etc/apt/sources.list.d/nginx.list && \
    echo "deb-src http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list.d/nginx.list && \
    apt update && \
    apt install -y --no-install-recommends \
        nginx \
        supervisor \
        php7.1-apc \
        php7.1-apcu \
        php7.1-bz2 \
        php7.1-bcmath \
        php7.1-calendar \
        php7.1-cgi \
        php7.1-cli \
        php7.1-ctype \
        php7.1-curl \
        php7.1-fpm \
        php7.1-geoip \
        php7.1-gettext \
        php7.1-gd \
        php7.1-intl \
        php7.1-imap \
        php7.1-ldap \
        php7.1-mbstring \
        php7.1-mcrypt \
        php7.1-memcached \
        php7.1-mongo \
        php7.1-mysql \
        php7.1-pdo \
        php7.1-pgsql \
        php7.1-redis \
        php7.1-soap \
        php7.1-sqlite3 \
        php7.1-ssh2 \
        php7.1-zip \
        php7.1-xmlrpc \
        php7.1-xsl && \
    # COMPOSER #################################################################
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require "hirak/prestissimo:^0.3" && \
    # PHP MOD(s) ###############################################################
    rm ${PHP_FPM_POOL_DIR}/www.conf && \
    # NGINX ####################################################################
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    # CLEAN UP #################################################################
    rm /etc/nginx/conf.d/default.conf && \
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get remove -y wget curl && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

# PHP
ADD ./php/php-fpm.conf /etc/php/7.1/

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
