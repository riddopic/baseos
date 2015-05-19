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

FROM       fedora:21
MAINTAINER Stefano Harding <riddopic@gmail.com>

    # Create Kitchen user
RUN useradd -c 'Test Kitchen' -d /home/kitchen -m kitchen -s /bin/bash
ADD root /
    # Setup yum repos
RUN rm -f /etc/yum.repos.d/fedora-updates*.repo                               ;\
    yum -y update                                                             ;\
    rm -f /etc/yum.repos.d/fedora-updates*.repo                               ;\
    yum -y install deltarpm yum-utils tar unzip sudo                          ;\
    # Create Kitchen user
    echo kitchen:kitchen | chpasswd                                           ;\
    echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers                     ;\
    echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/kitchen           ;\
    # Add s6 Overlay
    tar xvfz /s6-overlay.tar.gz -C /                                          ;\
    rm /s6-overlay.tar.gz                                                     ;\
    # Setup Chef Client
    yum -y install chef which curl openssh-server openssh-clients             ;\
    /opt/chef/embedded/bin/gem install pry awesome_print                      ;\
    # Setup Serf agent
    useradd -c 'Serf' -d /opt/serf -M serf -s /sbin/nologin                   ;\
    unzip -o /serf.zip -d /opt/serf/sbin/                                     ;\
    rm -f /serf.zip                                                           ;\
    ln -s /opt/serf/config    /etc/serf                                       ;\
    ln -s /opt/serf/log       /var/log/serf                                   ;\
    ln -s /opt/serf/sbin/serf /usr/local/sbin/serf                            ;\
    chown -R serf:serf /opt/serf                                              ;\
    chown root:serf    /opt/serf/config                                        \
                       /opt/serf/sbin/serf                                     \
                       /opt/serf/event_handlers/*                             ;\
    chmod 750          /opt/serf                                               \
                       /opt/serf/config                                        \
                       /opt/serf/sbin/serf                                     \
                       /opt/serf/event_handlers/*                             ;\
    # Setup Consul agent
    useradd -c 'Consul' -d /opt/consul -M consul -s /sbin/nologin             ;\
    unzip -o /0.5.1_linux_amd64.zip -d /opt/consul/sbin/                      ;\
    rm -f 0.5.1_linux_amd64.zip                                               ;\
    ln -s /opt/consul/config      /etc/consul                                 ;\
    ln -s /opt/consul/log         /var/log/consul                             ;\
    ln -s /opt/consul/sbin/consul /usr/sbin/consul                            ;\
    chown -R consul:consul        /opt/consul                                 ;\
    chown root:consul  /opt/consul/config                                      \
                       /opt/consul/sbin/consul                                ;\
    chmod 750          /opt/consul                                             \
                       /opt/consul/config                                      \
                       /opt/consul/sbin/consul                                ;\
    # Add SSH Keys
    chown -R root ~root/.ssh                                                  ;\
    chmod -R go-rwsx ~root/.ssh                                               ;\
    chown -R kitchen ~kitchen/.ssh                                            ;\
    chmod -R go-rwsx ~kitchen/.ssh                                            ;\
    yum clean all                                                             ;\
    rm -rf /tmp/*                                                              \
           /var/tmp/*                                                          \
           /var/cache/*

ENTRYPOINT ["/init"]

CMD []
