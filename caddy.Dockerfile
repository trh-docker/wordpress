FROM quay.io/spivegin/php7

WORKDIR /opt/tlm/html 

RUN git clone https://github.com/thirtybees/thirtybees.git . &&\
    chown -R www-data:www-data . &&\
    composer install &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]
