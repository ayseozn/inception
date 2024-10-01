FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/dbstart.sh /

RUN chmod +x /dbstart.sh

ENTRYPOINT [ "/dbstart.sh" ]

CMD [ "mariadbd" ]
