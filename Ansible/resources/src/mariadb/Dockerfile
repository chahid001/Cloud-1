FROM debian:buster

RUN apt -y update
RUN apt -y install mariadb-server

RUN sed -i 's/#port/port /g' /etc/mysql/mariadb.conf.d/50-server.cnf
RUN sed -i 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/db.sql /temp/db.sql

RUN service mysql start && mysql < /temp/db.sql

ENTRYPOINT [ "mysqld" ]