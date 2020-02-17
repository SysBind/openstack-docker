FROM alpine:3.10
RUN apk add --update python3 libpq postgresql-client
RUN apk add --virtual build-deps git gcc python3-dev musl-dev libffi-dev openssl-dev postgresql-dev
RUN git clone https://github.com/openstack/horizon.git -b stable/train
RUN cd horizon && pip3 install -e .
RUN pip3 install uwsgi psycopg2
# cleanup
RUN apk del build-deps
