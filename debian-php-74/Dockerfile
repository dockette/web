FROM dockette/debian:buster

# PHP
ENV PHP_MODS_DIR=/etc/php/7.4/mods-available
ENV PHP_CLI_DIR=/etc/php/7.4/cli/
ENV PHP_CLI_CONF_DIR=${PHP_CLI_DIR}/conf.d
ENV PHP_CGI_DIR=/etc/php/7.4/cgi/
ENV PHP_CGI_CONF_DIR=${PHP_CGI_DIR}/conf.d
ENV PHP_FPM_DIR=/etc/php/7.4/fpm/
ENV PHP_FPM_CONF_DIR=${PHP_FPM_DIR}/conf.d
ENV PHP_FPM_POOL_DIR=${PHP_FPM_DIR}/pool.d
ENV TZ=Europe/Prague

# INSTALLATION
RUN apt update && apt dist-upgrade -y && \
    # DEPENDENCIES #############################################################
    apt install -y wget curl apt-transport-https ca-certificates gnupg2 cron && \
    # PHP DEB.SURY.CZ ##########################################################
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ buster main" > /etc/apt/sources.list.d/php.list && \
    wget -O- http://nginx.org/keys/nginx_signing.key | apt-key add - && \
    echo "deb http://nginx.org/packages/debian/ buster nginx" > /etc/apt/sources.list.d/nginx.list && \
    echo "deb-src http://nginx.org/packages/debian/ buster nginx" >> /etc/apt/sources.list.d/nginx.list && \
    apt update && \
    apt install -y --no-install-recommends \
        nginx \
        supervisor \
        php7.4-apc \
        php7.4-apcu \
        php7.4-bz2 \
        php7.4-bcmath \
        php7.4-calendar \
        php7.4-cgi \
        php7.4-cli \
        php7.4-ctype \
        php7.4-curl \
        php7.4-fpm \
        php7.4-geoip \
        php7.4-gettext \
        php7.4-gd \
        php7.4-intl \
        php7.4-imap \
        php7.4-ldap \
        php7.4-mbstring \
        php7.4-memcached \
        php7.4-mongo \
        php7.4-mysql \
        php7.4-pdo \
        php7.4-pgsql \
        php7.4-redis \
        php7.4-soap \
        php7.4-sqlite3 \
        php7.4-ssh2 \
        php7.4-tidy \
        php7.4-zip \
        php7.4-xmlrpc \
        php7.4-xsl && \
    # COMPOSER #################################################################
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --2 && \
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

# CRON
RUN truncate -s 0 /etc/crontab

# PHP
ADD ./php/php-fpm.conf /etc/php/7.4/

# NGINX
ADD ./nginx/nginx.conf /etc/nginx/
ADD ./nginx/mime.types /etc/nginx/
ADD ./nginx/sites.d /etc/nginx/sites.d

# WWW
ADD ./www /srv/www/

# SUPERVISOR
ADD ./supervisor/supervisord.conf /etc/supervisor/
ADD ./supervisor/services /etc/supervisor/conf.d/

# APPLICATION
WORKDIR /srv

# PORTS
EXPOSE 80
COPY entrypoint.sh /usr/sbin/entrypoint.sh
RUN chmod +x /usr/sbin/entrypoint.sh
CMD ["/usr/sbin/entrypoint.sh"]
