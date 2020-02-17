#!/bin/sh

if [ ! -z ${TESTING+x} ]; then
    psql --host db --tuples-only --user postgres -c "\l" | grep keystone || psql --host db --tuples-only --user postgres -c "CREATE DATABASE glance"
fi

glance-manage db_sync

uwsgi --http 0.0.0.0:5000 --wsgi-file /usr/bin/glance-wsgi-api

