#!/bin/sh

keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

if [ ! -z ${TESTING+x} ]; then
    psql --host db --tuples-only --user postgres -c "\l" | grep keystone || psql --host db --tuples-only --user postgres -c "CREATE DATABASE keystone"
fi

echo "CMD: $@"

if [ ! -z ${1+x} ]; then
    case "$1" in
	api)	    
	    keystone-manage db_sync
	    uwsgi --http 0.0.0.0:5000 --wsgi-file /usr/bin/keystone-wsgi-admin
	    ;;
	*)
	    echo "running arbitary command $@"
	    $@
	    ;;
    esac
else
    keystone-manage db_sync
    uwsgi --http 0.0.0.0:5000 --wsgi-file /usr/bin/keystone-wsgi-admin
fi

