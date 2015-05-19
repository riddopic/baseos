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

# Add commonly used packages
ADD root /
RUN apk add --update go git gcc musl-dev dnsmasq bind-tools                   ;\
    GOPATH=/go go get github.com/hashicorp/consul                             ;\
    cd /opt/consul/sbin                                                       ;\
    GOPATH=/go go build github.com/hashicorp/consul                           ;\
    apk del go git gcc musl-dev                                               ;\
    # Add s6 Overlay
    tar xvfz /s6-overlay.tar.gz -C /                                          ;\
    rm /s6-overlay.tar.gz                                                     ;\
    # Setup Consul agent
    addgroup -S consul                                                        ;\
    adduser -SDs /sbin/nologin -G consul -g Consul -Hh /opt/consul consul     ;\
    ln -s /opt/consul/config      /etc/consul                                 ;\
    ln -s /opt/consul/log         /var/log/consul                             ;\
    ln -s /opt/consul/sbin/consul /usr/sbin/consul                            ;\
    chown -R consul:consul /opt/consul                                        ;\
    chown root:consul      /opt/consul/config                                  \
                           /opt/consul/sbin/consul                            ;\
    chmod 750              /opt/consul                                         \
                           /opt/consul/config                                  \
                           /opt/consul/sbin/consul                            ;\
    # Setup Serf agent
    addgroup -S serf                                                          ;\
    adduser -SDs /sbin/nologin -G serf -g Serf -Hh /opt/serf serf             ;\
    unzip -o /serf.zip -d /opt/serf/sbin/                                     ;\
    rm -f /serf.zip                                                           ;\
    ln -s /opt/serf/config    /etc/serf                                       ;\
    ln -s /opt/serf/log       /var/log/serf                                   ;\
    ln -s /opt/serf/sbin/serf /usr/sbin/serf                                  ;\
    chown -R serf:serf /opt/serf                                              ;\
    chown root:serf    /opt/serf/config                                        \
                       /opt/serf/sbin/serf                                     \
                       /opt/serf/event_handlers/*                             ;\
    chmod 750          /opt/serf                                               \
                       /opt/serf/config                                        \
                       /opt/serf/sbin/serf                                     \
                       /opt/serf/event_handlers/*                             ;\
    # Add SSH Keys
    chown -R root ~root/.ssh                                                  ;\
    chmod -R go-rwsx ~root/.ssh                                               ;\
    rm -rf /tmp/*

ENTRYPOINT ["/init"]
CMD []
