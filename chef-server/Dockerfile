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

FROM       riddopic/ubuntu-14.04
MAINTAINER Stefano Harding <riddopic@gmail.com>

EXPOSE 80 443
VOLUME ["/var/opt/opscode"]

ENV DEBIAN_FRONTEND noninteractive

# Setup Chef Server
RUN apt-get -yq update ;\
    apt-get install -yq logrotate hardlink chef-server-core ;\
    rm -rf /etc/opscode ;\
    ln -sfv /var/opt/opscode/log         /var/log/opscode ;\
    ln -sfv /var/opt/opscode/etc         /etc/opscode ;\
    ln -sfv /opt/opscode/sv/logrotate    /opt/opscode/service ;\
    ln -sfv /opt/opscode/embedded/bin/sv /opt/opscode/init/logrotate ;\
    chef-apply -e 'chef_gem "knife-opc"'

ADD root /
RUN apt-get -yq clean;\
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/cache/apt/archives/*

ENTRYPOINT ["/init"]

CMD ["/bin/bash"]
