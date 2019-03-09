FROM quay.io/spivegin/apache

WORKDIR /var/www/html 

RUN apt-get update &&\
    apt-get install -y php7.0-zip &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*


RUN git clone https://github.com/DanielnetoDotCom/YouPHPTube.git . &&\
    chown -R www-data:www-data .


EXPOSE 80
ADD files/apache2/sites-enabled/00-default.conf /etc/apache2/sites-enabled/
ADD files/php/php.ini /etc/php/7.0/apache2/
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]