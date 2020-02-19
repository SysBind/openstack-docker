FROM alpine:3.10
RUN apk add --update python3 libpq postgresql-client
RUN apk add --virtual build-deps git gcc python3-dev musl-dev libffi-dev openssl-dev postgresql-dev make libxml2-dev libxslt-dev
RUN git clone https://github.com/openstack/nova.git -b stable/train
RUN cd nova && pip3 install -e .
RUN pip3 install uwsgi psycopg2
RUN mkdir /etc/nova
COPY nova.conf /etc/nova/nova.conf
COPY api-paste.ini /etc/nova/api-paste.ini
COPY entrypoint.sh /
# cleanup
RUN apk del build-deps

ENTRYPOINT ["/entrypoint.sh"]
CMD ["api"]

