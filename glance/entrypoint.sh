#!/bin/sh

if [ ! -z ${TESTING+x} ]; then
    psql --host db --tuples-only --user postgres -c "\l" | grep keystone || psql --host db --tuples-only --user postgres -c "CREATE DATABASE glance"
fi

echo "CMD: $@"

if [ ! -z ${1+x} ]; then
    echo "got param $1"
    case "$1" in
	registry)
	    glance-registry
	    ;;
	api)
	    glance-manage db_sync
	    /usr/bin/glance-api
	    ;;
	*)
	    echo "running arbitary command $@"
	    $@
	    ;;
    esac
else
    glance-manage db_sync
    uwsgi --http 0.0.0.0:9292 --wsgi-file /usr/bin/glance-wsgi-api
fi


