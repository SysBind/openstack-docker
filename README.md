![Logo](https://github.com/SysBind/openstack-docker/blob/master/logo.png)
# openstack-docker
Open Stack Docker Images


Use those images to deploy OpenStack services, Currently building on Train stable branch.

No environment variables support, use volumes to configure, 
e.g: /etc/keystone/keystone.cfg
or entire /etc/keystone

All images will run `x-manage db sync` upon starting with the 'api' command
(In case of Nova, also `nova-manage api_db sync` will run, or `neutron-db-manage upgrade head` for Neutron)

## Keystone (Identity Service)

_Minimum config_: 
- /etc/keystone/keystone.cfg

_Commands_:
- Only default: runs uwsgi server with the keystone API

or arbitary command

## Glance (Image Service)
_Minimum config_: 
- /etc/glance/glance-api.conf

If supplying entire /etc/glance as a volume,
You'll also need:
- /etc/glance/glance-api-paste.ini
- /etc/glance/glance-registry-paste.ini
(You can copy them from a running glance container)

_Commands_:
- api: default, run uwsgi with the glance API
- registry

or arbitary command

_Volumes_:
- /var/lib/glance/images

## Placement (Resource Provider Inventory Allocation Service)

_Minimum config_: 
- /etc/placement/placement.conf

_Commands_:
- api: default, run uwsgi with the placement API

or arbitary command


## Nova (Compute Service)

_Minimum config_: 
- /etc/nova/nova.conf

_Commands_:
- api: default, run uwsgi with the Nova API
- compute: run nova-compute
- scheduler: run nova-scheduler
- conductor: run nova-conductor
- novncproxy: run nova-novncproxy

or arbitary command

_Volumes_:
- nova-compute: /var/run/libvirt, /nova/instances

_Notes_:
- nova-compute should run with --priveleged
- nova-compute host should have working libvirt daemon running


## Neutron (Network Service)

_Minimum config_: 
- /etc/neutron/neutron.conf

_Commands_:
- api: default, Neutron API
- server: run neutron-server
- linuxbridge-agent
- dhcp-agent
- metadata-agent

or arbitary command

_Notes_:
- linuxbridge-agent should run with --cap-add=NET_ADMIN 
