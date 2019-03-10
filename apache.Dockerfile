FROM quay.io/spivegin/apache

WORKDIR /var/www/html 

ADD files/bash/composer.sh /opt/
RUN chmod +x /opt/composer.sh && /opt/composer.sh &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN a2enmod rewrite &&\
    rm -rf /var/www/html && mkdir /var/www/html && cd /var/www/html &&\
    git clone https://github.com/thirtybees/thirtybees.git . &&\
    chown -R www-data:www-data . &&\
    composer install &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

EXPOSE 80
ADD files/apache2/sites-enabled/ /etc/apache2/sites-enabled/
ADD files/php/php.ini /etc/php/7.0/apache2/
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]
