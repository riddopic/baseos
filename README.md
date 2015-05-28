
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

### ELKStack
Run the ELK stack the "Docker" way

Currently to get this setup working you will need to do the following:

 * Generate certificate(s) for Logstash
 * create a /data directory (or mount) to place LS and ES data

To change the default behavior of these Docker images you can adjust a few environment variables.

For example, you can modify the default amount of heap memory used for the Logstash and Elasticsearch images by adding a section in the config for `ES_HEAP_SIZE` and `LS_HEAP_SIZE`.  The default values for these are 8GB (for ES) and 2GB (for LS).

### Generate certificates for logstash

Modify the generate_certs.sh script to be executable and then generate self signed certs by running `chmod +x generate_certs.sh` from the command line, then run it to generate the certificates.

The certs should be placed in to the correct location within this repo for the Docker images to build.  The script builds the certs with a default expiration value of 10 years.  You can test out the certificate with the openssl checker by running something like `openssl x509 -noout -text  -in logstash/logstash-forwarder.crt` to look at the domain and expiration on the cert.

### Create /data directory to place data

For this configuration to work correctly you will either need to create the directories by hand or run the setup_dirs script to create the directores for volume mounts that Docker containers will use to write data to persistent storage.


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


# return last-run container id.
alias dlc='docker ps -l -q'

# remove all stopped containers
alias drm="docker ps -a | grep Exited | cut -d ' ' -f 1 | xargs docker rm"

# Kill all running containers.
alias dockerkillall='docker kill $(docker ps -q)'

# Delete all stopped containers.
alias dockercleanc='docker rm $(docker ps -a -q)'

# Delete all untagged images.
alias dockercleani='docker rmi -f $(docker images -q -f dangling=true)'

# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'



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

