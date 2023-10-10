FROM debian:buster

RUN apt -y update;
RUN apt install -y redis-server;

RUN sed -i 's/bind 127.0.0.1 ::1/bind 0.0.0.0/g' /etc/redis/redis.conf

ENTRYPOINT [ "redis-server", "--protected-mode", "no" ]