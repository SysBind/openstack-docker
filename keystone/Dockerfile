FROM alpine:3.10
RUN apk add --update python3 libpq postgresql-client
RUN apk add --virtual build-deps git gcc python3-dev musl-dev libffi-dev openssl-dev postgresql-dev
RUN git clone https://github.com/openstack/keystone.git -b stable/train
RUN cd keystone && pip3 install -e .
RUN pip3 install uwsgi psycopg2
RUN mkdir /etc/keystone
COPY keystone.conf /etc/keystone/keystone.conf
COPY entrypoint.sh /
RUN adduser -D keystone
# cleanup
RUN apk del build-deps

ENTRYPOINT ["/entrypoint.sh"]
CMD ["api"]
