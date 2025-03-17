FROM alpine:3.16

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf

EXPOSE 3306

COPY requirements/mariadb/conf/create_db.sh /tmp/
RUN chmod +x /tmp/create_db.sh

CMD ["/bin/sh", "-c", "/tmp/create_db.sh"]