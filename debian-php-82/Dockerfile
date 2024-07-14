FROM dockette/debian:bookworm

# PHP
ENV PHP_MODS_DIR=/etc/php/8.2/mods-available
ENV PHP_CLI_DIR=/etc/php/8.2/cli/
ENV PHP_CLI_CONF_DIR=${PHP_CLI_DIR}/conf.d
ENV PHP_CGI_DIR=/etc/php/8.2/cgi/
ENV PHP_CGI_CONF_DIR=${PHP_CGI_DIR}/conf.d
ENV PHP_FPM_DIR=/etc/php/8.2/fpm/
ENV PHP_FPM_CONF_DIR=${PHP_FPM_DIR}/conf.d
ENV PHP_FPM_POOL_DIR=${PHP_FPM_DIR}/pool.d
ENV PHP_FPM_BIN=/usr/sbin/php-fpm8.2
ENV PHP_FPM_CONF=/etc/php/8.2/php-fpm.conf
ENV TZ=Europe/Prague

# INSTALLATION
RUN apt update && apt dist-upgrade -y && \
    # DEPENDENCIES #############################################################
    apt install -y wget curl apt-transport-https ca-certificates gnupg2 cron && \
    # PHP DEB.SURY.CZ ##########################################################
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ bookworm main" > /etc/apt/sources.list.d/php.list && \
    wget -O- http://nginx.org/keys/nginx_signing.key | apt-key add - && \
    echo "deb http://nginx.org/packages/debian/ bookworm nginx" > /etc/apt/sources.list.d/nginx.list && \
    echo "deb-src http://nginx.org/packages/debian/ bookworm nginx" >> /etc/apt/sources.list.d/nginx.list && \
    apt update && \
    apt install -y --no-install-recommends \
        nginx \
        supervisor \
        php8.2-apcu \
        php8.2-bz2 \
        php8.2-bcmath \
        php8.2-calendar \
        php8.2-cgi \
        php8.2-cli \
        php8.2-ctype \
        php8.2-curl \
        php8.2-fpm \
        php8.2-gettext \
        php8.2-gd \
        php8.2-intl \
        php8.2-imap \
        php8.2-ldap \
        php8.2-mbstring \
        php8.2-memcached \
#        php8.2-mongo \
        php8.2-mysql \
        php8.2-pdo \
        php8.2-pgsql \
        php8.2-redis \
        php8.2-soap \
        php8.2-sqlite3 \
        php8.2-ssh2 \
        php8.2-tidy \
        php8.2-zip \
        php8.2-xmlrpc \
        php8.2-xsl && \
    # COMPOSER #################################################################
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --2 && \
    # NGINX ####################################################################
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    # CLEAN UP #################################################################
    rm /etc/nginx/conf.d/default.conf && \
    apt clean -y && \
    apt autoclean -y && \
    apt remove -y wget && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

# PHP
ADD ./php/php-fpm.conf /etc/php/8.2/
ADD ./php/php.ini /etc/php/8.2/conf.d/

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
