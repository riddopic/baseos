
# Chef Server

This image runs a Chef 12 Server.

### Environment Variables

 - `PUBLIC_URL` - should be configured to a full public URL of the
   endpoint (e.g. `https://chef.example.com`)
 - `OC_ID_ADMINISTRATORS` - if set, it should be a comma-separated
   list of users that will be allowed to add oc_id applications

### Ports

Ports 80 (HTTP) and 443 (HTTPS) are exposed.

## Usage

To start the container (replace ${FQDN} with the name of the server):

    docker run -de 'PUBLIC_URL=https://${FQDN}/' -h ${FQDN} acme/chef-server

### Prerequisites and first start

The `kernel.shmmax` and `kernel.shmall` sysctl values should be set to
a high value on the host. You may also run Chef server as a privileged
container to let it auto-configure -- but the setting will propagate to
host anyway, and it would be the only reason for making the container
privileged, so it is better to avoid it.

To set the `kernel.shmmax` and `kernel.shmall` sysctl values run the following
on your docker hosts:

    sudo sysctl -w kernel.shmmax=17179869184
    sudo sysctl -w kernel.shmall=4194304

To make the change permanent add the values to `/etc/sysctl.con`:

    echo "kernel.shmmax=17179869184" >> /etc/sysctl.conf
    echo "kernel.shmall=4194304" >> /etc/sysctl.conf

First start will automatically run `chef-server-ctl
reconfigure`. Subsequent starts will not run `reconfigure`, unless
file `/var/opt/opscode/bootstrapped` has been deleted. You can run
`reconfigure` (e.g. after editing `etc/chef-server.rb`) using
`docker-enter`.

### Maintenance commands

Chef Server's design makes it impossible to wrap it cleanly in
a container - it will always be necessary to run custom
commands. While some of the management commands may work with linked
containers with varying amount of ugly hacks, it is simpler to have
one way of interacting with the software that is closest to
interacting with a Chef Server installed directly on host (and thus
closest to supported usage).

This means you need Docker 1.3+ with `docker exec` feature, and run
`chef-server-ctl` commands like:

    docker exec $CONTAINER_ID chef-server-ctl status
    docker exec $CONTAINER_ID chef-server-ctl user-create …
    docker exec $CONTAINER_ID chef-server-ctl org-create …
    docker exec $CONTAINER_ID chef-server-ctl …

### Customize

If there is a file `/etc/chef-server-local.rb`, it will be read at the end of
`chef-server.rb` and it can be used to customize Chef Server's settings.

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

