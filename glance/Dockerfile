FROM alpine:3.10
RUN apk add --update python3 libpq postgresql-client
RUN apk add --virtual build-deps git gcc python3-dev musl-dev libffi-dev openssl-dev postgresql-dev
RUN git clone https://github.com/openstack/glance.git -b stable/train
RUN cd glance && pip3 install -e .
RUN pip3 install uwsgi psycopg2
RUN mkdir /etc/glance
COPY glance-api.conf /etc/glance/glance-api.conf
COPY glance-api-paste.ini /etc/glance/glance-api-paste.ini
COPY entrypoint.sh /
ENTRYPOINT /entrypoint.sh

# cleanup
RUN apk del build-deps

