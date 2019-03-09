FROM quay.io/spivegin/php7

WORKDIR /var/www/html 


RUN rm * &&\
    git clone https://github.com/DanielnetoDotCom/YouPHPTube.git /var/www/html  &&\
    chown -R www-data:www-data .
    

EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]