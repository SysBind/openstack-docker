#!/bin/sh

if [ ! -z ${TESTING+x} ]; then
    psql --host db --tuples-only --user postgres -c "\l" | grep neutron || psql --host db --tuples-only --user postgres -c "CREATE DATABASE neutron"
fi

echo "CMD: $@"

if [ ! -z ${1+x} ]; then
    echo "got param $1"
    case "$1" in
	api)
	    neutron-db-manage upgrade head
	    uwsgi --http 0.0.0.0:9696 --wsgi-file /usr/bin/neutron-api
	    ;;
	server)
	    neutron-server
	    ;;
        linuxbridge-agent)
	    neutron-linuxbridge-agent
	    ;;
	dhcp-agent)
	    neutron-dhcp-agent
	    ;;
	metadata-agent)
	    neutron-metadata-agent
	    ;;
	*)
	    echo "running arbitary command $@"
	    $@
	    ;;
    esac
else
    neutron-db-manage upgrade head
    uwsgi --http 0.0.0.0:9696 --wsgi-file /usr/bin/neutron-api
fi


