FROM debian:bullseye-slim

RUN apt-get update && apt-get upgrade -y 

RUN apt-get install mariadb-server mariadb-client -y && apt-get clean

RUN sed -i "s/^bind-address\s*=.*$/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

WORKDIR /setup

COPY ./mariadb-setup.sh /setup/mariadb-setup.sh

RUN chmod +x mariadb-setup.sh

ENTRYPOINT [ "sh", "/setup/mariadb-setup.sh" ]

CMD [ "mysqld_safe" ]
