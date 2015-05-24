# encoding: UTF-8

FROM       riddopic/ubuntu-14.04
MAINTAINER Stefano Harding <riddopic@gmail.com>

EXPOSE 22
VOLUME ["/var/lib/docker"]

ADD root /
RUN apt-get-min update                                                        ;\
    apt-get-install-min apt-transport-https ca-certificates curl lxc iptables ;\
    curl -sSL https://get.docker.com/ubuntu/ | sh                             ;\
    chmod +x /usr/sbin/wrapdocker                                             ;\
    apt-get-min clean                                                         ;\
    rm -rf /tmp/*                                                              \
           /var/tmp/*                                                          \
           /var/lib/apt/lists/*                                                \
           /var/cache/apt/archives/*
