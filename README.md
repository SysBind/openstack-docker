# openstack-docker
Open Stack Docker Images


Use those images to deploy OpenStack services, Currently building on Train stable branch.

No environment variables support, use volumes to configure, 
e.g: /etc/keystone/keystone.cfg
or entire /etc/keystone

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
