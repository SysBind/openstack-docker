#!/bin/sh

if [ ! -z ${TESTING+x} ]; then
    psql --host db --tuples-only --user postgres -c "\l" | grep placement || psql --host db --tuples-only --user postgres -c "CREATE DATABASE placement"
fi

echo "CMD: $@"

if [ ! -z ${1+x} ]; then
    case "$1" in
	api)
	    placement-manage db sync
	    uwsgi --http 0.0.0.0:8778 --wsgi-file /usr/bin/placement-api
	    ;;
	*)
	    echo "running arbitary command $@"
	    $@
	    ;;
    esac
else
    placement-manage db sync
    uwsgi --http 0.0.0.0:8778 --wsgi-file /usr/bin/placement-api	      
fi	    

