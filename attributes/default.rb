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

override[:yum][:fedora][:mirrorlist]     =
  'http://io.dev/?release=$releasever&arch=$basearch&repo=$osname-os'

override[:yum][:base][:mirrorlist]       =
  'http://io.dev/?release=$releasever&arch=$basearch&repo=$osname-os'

override[:yum][:contrib][:mirrorlist]    =
  'http://io.dev/?release=$releasever&arch=$basearch&repo=$osname-contrib'

override[:yum][:extras][:mirrorlist]     =
  'http://io.dev/?release=$releasever&arch=$basearch&repo=$osname-extras'

override[:yum][:fasttrack][:mirrorlist]  =
  'http://io.dev/?release=$releasever&arch=$basearch&repo=$osname-fasttrack'

override[:yum][:centosplus][:mirrorlist] =
  'http://io.dev/?release=$releasever&arch=$basearch&repo=$osname-centosplus'

override[:yum][:updates][:mirrorlist]    =
  'http://io.dev/?release=$releasever&arch=$basearch&repo=$osname-updates'

override[:yum][:epel][:mirrorlist]       =
  'http://io.dev/?release=$releasever&arch=$basearch&repo=epel'

# EPEL
override[:yum][:epel][:gpgkey]           =
  'http://mirrors.mudbox.dev/fedora-epel/RPM-GPG-KEY-EPEL-$releasever'

override[:yum][:fedora][:mirrorlist]     =
  'http://io.dev/?release=$releasever&arch=$basearch&repo=$osname-os'
