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

# Add commonly used packages
RUN apk add --update bind-tools                                               ;\
    rm -rf /var/cache/apk/*                                                   ;\
    # Add s6 Overlay
    tar xvfz /s6-overlay.tar.gz -C /                                          ;\
    # Setup Serf agent
    addgroup -S serf                                                          ;\
    adduser -S -h /opt/serf -H -D -s /sbin/nologin -G serf serf               ;\
    unzip -o /serf.zip -d /opt/serf/sbin/                                     ;\
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
    chmod 1777 /tmp                                                           ;\
    chown root:root /tmp                                                      ;\
    rm -rf /tmp/*

ENTRYPOINT ["/init"]

CMD ["/bin/sh"]
