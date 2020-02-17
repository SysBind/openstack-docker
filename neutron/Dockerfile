FROM alpine:3.10
RUN apk add --update python3 libpq postgresql-client
RUN apk add --virtual build-deps git gcc python3-dev musl-dev libffi-dev openssl-dev postgresql-dev make
RUN git clone https://github.com/openstack/neutron.git -b stable/train
RUN cd neutron && pip3 install -e .
RUN pip3 install uwsgi psycopg2
# cleanup
RUN apk del build-deps
