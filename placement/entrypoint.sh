#!/bin/sh

if [ ! -z ${TESTING+x} ]; then
    psql --host db --tuples-only --user postgres -c "\l" | grep placement || psql --host db --tuples-only --user postgres -c "CREATE DATABASE placement"
fi

placement-manage db sync

uwsgi --http 0.0.0.0:5000 --wsgi-file /usr/bin/placement-api

