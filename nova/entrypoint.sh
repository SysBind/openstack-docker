#!/bin/sh

if [ ! -z ${TESTING+x} ]; then
    psql --host db --tuples-only --user postgres -c "\l" | grep nova_api || psql --host db --tuples-only --user postgres -c "CREATE DATABASE nova_api"
    psql --host db --tuples-only --user postgres -c "\l" | grep nova | grep -v nova_api || psql --host db --tuples-only --user postgres -c "CREATE DATABASE nova"    
fi

echo "CMD: $@"

if [ ! -z ${1+x} ]; then
    echo "got param $1"
    case "$1" in
	compute)	    
	    nova-compute
	    ;;
	api)
	    nova-manage db sync
	    nova-manage api_db sync
	    /usr/bin/nova-api
	    ;;
	*)
	    echo "running arbitary command $@"
	    $@
	    ;;
    esac
else
    nova-manage db sync
    nova-manage api_db sync
    uwsgi --http 0.0.0.0:8774 --wsgi-file /usr/bin/nova-api-wsgi
fi


