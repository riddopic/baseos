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

EXPOSE 4545 4546
ENV LS_HEAP_SIZE=2g GOMAXPROCS=2 DEBIAN_FRONTEND=noninteractive
ADD https://download.elastic.co/logstash/logstash/logstash-1.5.0.tar.gz / \
    root /
RUN tar zxf /logstash-1.5.0.tar.gz -C /opt/ && \
    mv /opt/logstash-1.5.0/ /opt/logstash && \
    rm /logstash-1.5.0.tar.gz && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select \
    true | debconf-set-selections && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get-min update && \
    apt-get-install-min wget python  oracle-java7-installer && \
    /opt/logstash/bin/plugin update  logstash-output-zeromq && \
    /opt/logstash/bin/plugin install logstash-input-log-courier && \
    apt-get-min clean && \
    rm -rf /var/cache/oracle-jdk7-installer && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/cache/apt/archives/*
