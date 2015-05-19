# encoding: UTF-8
#
# Author:    Stefano Harding <riddopic@gmail.com>
# License:   Apache License, Version 2.0
# Copyright: (C) 2014-2015 Stefano Harding
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM       alpine:3.1
MAINTAINER Stefano Harding <riddopic@gmail.com>

ADD root /
ENV CONSUL_VERSION=0.5.2 GOMAXPROCS=2
RUN tar xvfz /s6-overlay-amd64.tar.gz -C /                                    ;\
    #
    # Setup Consul agent
    #
    apk add --update go git gcc musl-dev bind-tools                           ;\
    GOPATH=/go go get github.com/hashicorp/consul                             ;\
    cd /usr/sbin                                                              ;\
    GOPATH=/go go build github.com/hashicorp/consul                           ;\
    apk del go git gcc musl-dev                                               ;\
    rm -rf /go /var/cache/apk/*                                               ;\
    mkdir /srv /data                                                          ;\
    addgroup -S consul                                                        ;\
    adduser -SDs /sbin/nologin -G consul -g Consul -h /srv/consul consul      ;\
    chown -R consul:  /srv/consul                                             ;\
    chmod 750         /srv/consul                                             ;\
    chown root:consul /usr/sbin/consul                                        ;\
    chmod 750         /usr/sbin/consul                                        ;\
    chown root:consul /etc/consul                                             ;\
    chmod 750         /etc/consul                                             ;\
    chown -R consul:  /data                                                   ;\
    chmod 750         /data                                                   ;\
    #
    # Setup Serf agent
    #
    addgroup -S serf                                                          ;\
    adduser -SDs /sbin/nologin -G serf -g Serf -h /srv/serf serf              ;\
    unzip -o /0.6.4_linux_amd64.zip -d /usr/sbin/                             ;\
    chown -R serf:  /srv/serf                                                 ;\
    chmod 750       /srv/serf                                                 ;\
    chown root:serf /usr/sbin/serf                                            ;\
    chmod 750       /usr/sbin/serf                                            ;\
    chown root:serf /etc/serf                                                 ;\
    chmod 750       /etc/serf                                                 ;\
    #
    # Add SSH Keys
    #
    chown -R root ~root/.ssh                                                  ;\
    chmod -R go-rwsx ~root/.ssh                                               ;\
    #
    # Cleanup
    #
    rm -rf /tmp/* /s6-overlay-amd64.tar.gz /0.6.4_linux_amd64.zip

ENTRYPOINT ["/init"]

CMD []
