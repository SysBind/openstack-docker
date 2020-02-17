FROM alpine:3.10
RUN apk add --update python3 libpq postgresql-client
RUN apk add --virtual build-deps git gcc python3-dev musl-dev libffi-dev openssl-dev postgresql-dev
RUN git clone https://github.com/openstack/placement.git -b stable/train
RUN cd placement && pip3 install -e .
RUN pip3 install uwsgi psycopg2
RUN mkdir /etc/placement
COPY placement.conf /etc/placement/placement.conf
COPY entrypoint.sh /
ENTRYPOINT /entrypoint.sh
# cleanup
RUN apk del build-deps

