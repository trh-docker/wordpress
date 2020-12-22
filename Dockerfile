FROM quay.io/spivegin/apache

WORKDIR /var/www/html 

RUN apt-get update &&\ 
    apt-get install -y php7.0-zip php7.0-bcmath php7.0-imap php7.0-curl php7.0-opcache php7.0-mysql && \
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* 
# apt install php7.0-gd php7.0-bcmath php7.0-xml php7.0-json php7.0-zip php7.0-mysql php7.0-mbstring
# php7.0-imap php7.0-curl php7.0-opcache

RUN rm -rf /var/www/html && mkdir /var/www/html && cd /var/www/html &&\
    git clone https://github.com/WordPress/WordPress.git --recursive -b 5.3 . &&\
    git clone https://github.com/kevinoid/postgresql-for-wordpress.git  /tmp/ &&\
    mv  /tmp/pg4wp wp-content/ &&\
    cp wp-content/pg4wp/db.php wp-content/db.php &&\

    # rm -rf themes/community-theme-default &&\
    # git clone https://github.com/trhhosting/thritybees-theme.git themes/community-theme-default &&\
    # composer.phar install &&\
    chown -R www-data:www-data . &&\
    a2enmod rewrite &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

EXPOSE 80
ADD files/apache2/sites-enabled/ /etc/apache2/sites-enabled/
ADD files/php/php.ini /etc/php/7.0/apache2/
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]
