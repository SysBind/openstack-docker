FROM alpine:3.10
RUN apk add --update python3 libpq postgresql-client
RUN apk add --virtual build-deps git gcc python3-dev musl-dev libffi-dev openssl-dev postgresql-dev make
RUN pip3 install uwsgi psycopg2
RUN git clone https://github.com/openstack/neutron.git -b stable/train
RUN cd neutron && pip3 install -e .
RUN apk del build-deps && rm -rf /neutron/.git
RUN mkdir /etc/neutron
COPY neutron.conf /etc/neutron/neutron.conf
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["api"]
