    # Bruno Fernandez
    FROM php:5-apache
    MAINTAINER Bruno Fernandez <bruno@triptribus.com>

    # Ignore APT warnings about not having a TTY
    ENV DEBIAN_FRONTEND noninteractive

    # Php Modules a activer
    RUN apt-get update && apt-get install -y  --no-install-recommends libmcrypt-dev python-pip python-wheel python-setuptools libicu-dev g++ \
        && docker-php-ext-install mbstring \
        && docker-php-ext-install mcrypt \
        && docker-php-ext-install mysql \
        && docker-php-ext-install mysqli \
        && docker-php-ext-install pdo_mysql \
        && docker-php-ext-install intl \
        && pear install channel://pear.php.net/HTTP_WebDAV_Server-1.0.0RC8 \
	&& pear install Auth_SASL \
	&& pear install Net_IMAP \
	&& pear install XML_Feed_Parser \
	&& pear install pear install Net_Sieve \
        && pip install j2cli \
        && apt-get install -y wget \
        && wget "https://downloads.sourceforge.net/project/roundcubemail/roundcubemail/1.1.3/roundcubemail-1.1.3-complete.tar.gz" -O roundcubemail.tar.gz \
        && tar xf roundcubemail.tar.gz -C /var/www/html --strip-components 1 \
        && chown -R root:www-data /var/www/html \
        && chmod g+w /var/www/html/logs /var/www/html/temp 

    ENV TIMEZONE America/Toronto
    # Copie la configuration en format Jinja2
    COPY conf/config.inc.php.j2 /root/
    COPY conf/php.ini.j2 /root/
    # script pour la substitution
    ADD run.sh /

    CMD ["/run.sh"]

