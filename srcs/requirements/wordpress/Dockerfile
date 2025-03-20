FROM debian:bookworm

RUN apt-get update && apt-get install -y php-fpm php-mysqli curl

RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf

RUN apt-get install -y wget curl

WORKDIR /app

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp 

COPY wp-setup.sh /app/wp-setup.sh

RUN chmod +x /app/wp-setup.sh

ENTRYPOINT [ "bash", "/app/wp-setup.sh" ]

CMD ["php-fpm8.2", "-F"]