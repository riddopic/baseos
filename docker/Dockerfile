# encoding: UTF-8

FROM       riddopic/ubuntu-14.04
MAINTAINER Stefano Harding <riddopic@gmail.com>

VOLUME /var/lib/docker

# Install Docker
ADD root /
RUN apt-get -yq update                                                        ;\
    apt-get install -yq apt-transport-https ca-certificates curl lxc iptables ;\
    curl -sSL https://get.docker.com/ubuntu/ | sh                             ;\
    chmod +x /usr/local/bin/wrapdocker                                        ;\
    chmod +x /etc/services.d/docker/run

# Cleanup
RUN apt-get-min clean                                                         ;\
    rm -rf /tmp/*                                                              \
           /var/tmp/*                                                          \
           /var/lib/apt/lists/*                                                \
           /var/cache/apt/archives/*

ENTRYPOINT ["/init"]

CMD ["/bin/bash"]
