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

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
EXPOSE 5601
ADD root /
RUN apt-key adv --fetch-keys                                                   \
    "http://packages.elasticsearch.org/GPG-KEY-elasticsearch"                 ;\
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select     \
    true | debconf-set-selections                                             ;\
    add-apt-repository -y ppa:webupd8team/java                                ;\
    apt-get-min update                                                        ;\
    apt-get-install-min oracle-java7-installer                                ;\
    apt-get-min clean                                                         ;\
    rm -rf /var/cache/oracle-jdk7-installer                                   ;\
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/cache/apt/archives/*
