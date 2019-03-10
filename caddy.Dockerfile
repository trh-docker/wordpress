FROM quay.io/spivegin/php7

WORKDIR /opt/tlm/html 

RUN apt-get update &&\
    apt-get install -y php7.0-zip php7.0-bcmath  && \
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* &&\

RUN git clone https://github.com/thirtybees/thirtybees.git . &&\
    chown -R www-data:www-data . &&\
    composer.phar install &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]
