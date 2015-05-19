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

FROM       ubuntu:14.04
MAINTAINER Stefano Harding <riddopic@gmail.com>

# Prevents initramfs updates from trying to run grub and lilo.
ENV INITRD no

    # Create Kitchen user
RUN useradd -c 'Test Kitchen' -d /home/kitchen -m kitchen -s /bin/bash
ADD root /
    # Add MudBox keys and insure exec permission to utils.
RUN apt-key add /etc/apt/mudbox.key && rm -f /etc/apt/mudbox.key              ;\
    chmod +x /usr/bin/apt-cleanup                                              \
             /usr/bin/apt-dpkg-wrapper                                         \
             /usr/bin/apt-get-install                                         ;\
    ls /usr/bin/apt* /usr/bin/dpkg* |                                          \
    while read line; do                                                        \
      min=$line-min                                                           ;\
      printf '#!/bin/sh\n/usr/bin/apt-dpkg-wrapper '$line' $@\n' > $min       ;\
      chmod +x $min                                                           ;\
    done                                                                      ;\
    if [ ! -e /etc/dpkg/dpkg.cfg.d/docker-apt-speedup ]; then                  \
      echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup          ;\
    fi                                                                        ;\
    # Handle issue with APT packages and replace `ischroot` to return true which
    # should prevents initscripts updates from breaking /dev/shm.
    apt-get-min update                                                        ;\
    apt-get-install-min apt-utils                                             ;\
    dpkg-divert-min --local --rename --add /sbin/initctl                      ;\
    ln -sf /bin/true /sbin/initctl                                            ;\
    dpkg-divert-min --local --rename --add /usr/bin/ischroot                  ;\
    ln -sf /bin/true /usr/bin/ischroot                                        ;\
    apt-get-install-min apt-transport-https ca-certificates                   ;\
    apt-get-install-min software-properties-common                            ;\
    apt-get-min dist-upgrade -y --no-install-recommends                       ;\
    # Set locale to Америка.
    apt-get-install-min language-pack-en                                      ;\
    locale-gen en_US                                                          ;\
    update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8                       ;\
    tar xvfz /s6-overlay.tar.gz -C /                                          ;\
    rm /s6-overlay.tar.gz                                                     ;\
    # Setup Chef Client
    apt-key add /etc/apt/gpg.key && rm -f /etc/apt/gpg.key                    ;\
    mv /etc/chef_stable.list /etc/apt/sources.list.d/chef_stable.list         ;\
    apt-get-min update                                                        ;\
    apt-get-install-min chef sudo openssh-server curl lsb-release unzip       ;\
    /opt/chef/embedded/bin/gem install pry awesome_print                      ;\
    echo kitchen:kitchen | chpasswd                                           ;\
    echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers                     ;\
    echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/kitchen           ;\
    # Setup Serf agent
    useradd -c 'Serf' -d /opt/serf -M serf -s /sbin/nologin                   ;\
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
    apt-get-min clean                                                         ;\
    rm -rf /tmp/*                                                              \
           /var/tmp/*                                                          \
           /var/lib/apt/lists/*                                                \
           /var/cache/apt/archives/*

ENTRYPOINT ["/init"]

CMD []
