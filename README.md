
# La Collezione Dockerfile

Contained within this repo are Dockerfiles used for [Chef](chef) cookbook
development. As such they do not follow the normal Docker practice of
lightweight containers running a single process. Instead these are FatBoy™
containers complete with a process supervisor, SSH, [Serf](serf) and NTP.

In addition to using [s6](s6) for an init process these containers have also
been optimized to use a locally mirrored Yum and/or Apt repository and a caching
proxy is also employed. This helps reduce provisioning times greatly allowing
for a fast feedback loop between changes.

## Base images:

The containers are built from four different base images. Each image is
configured with [s6](s6) as the init process, and [Serf](serf) is used for node
discovery. The Yum and/or Apt repositories use a local mirror, additionally both
Ubuntu and CentOS images have the chef-stable repository installed (mirrored
locally). CentOS containers also have the EPEL repo installed.

 * Alpine Linux 3.1
 * CentOS 6.6
 * CentOS 7.1
 * Fedora 21
 * Ubuntu 12.04
 * Ubuntu 14.04

### Chef 12 Server

Based off the Ubuntu 'FatBoy' 14.04 image, this Chef server is not configured
with any redundancy nor is any of the data backed up. This is purposefully done
to ensure that it is regularly recycled and that anything used to build the
infrastructure is captured and automated.

More details on the Chef server and how to use it can be found in the README
with the Dockerfile.

### Installing Docker

Like all good things, installing Docker is an extremely complex and time-
consuming process, on OS X you can use [Homebrew](homebrew) to install both the
docker-machine and docker client binaries:

    brew install docker-machine
    brew install docker

OK, maybe it isn't that difficult...
                                           <`)))><
### Mini Docker cheat-sheet:

**NOTE:** Examples show here are for the [Fish](fish) shell, for `zsh` or `bash`
you will have to mangle appropriately.

Kill all running containers:

    docker kill (docker ps -q)

Remove all stopped containers:

    docker rm -f (docker ps -a | grep Exited | awk '{print $1}')

Clean up un-tagged docker images:

    docker rmi -f (docker images -q --filter "dangling=true")

Stop and remove all containers (including running containers!)

    docker rm -f (docker ps -a -q)

Clean all container images

    docker rmi -f (docker images -aq)

## License and Authors

Author::   Stefano Harding <riddopic@gmail.com>
Copyright: 2014-2015, Stefano Harding

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[chef]: https://www.chef.io/chef/
[serf]: https://www.serfdom.io
[s6]: http://www.skarnet.org/software/s6/
[homebrew]: http://brew.sh
[fish]: http://fishshell.com

