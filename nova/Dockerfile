FROM alpine:3.10
RUN apk add --update python3 libpq postgresql-client libxslt
RUN apk add --virtual build-deps git gcc python3-dev musl-dev libffi-dev openssl-dev postgresql-dev make libxml2-dev libxslt-dev pkgconfig
RUN git clone https://github.com/openstack/nova.git -b stable/train
RUN cd nova && pip3 install -e .
RUN pip3 install uwsgi psycopg2 libvirt-python

RUN apk del build-deps && rm -rfv /nova/.git
COPY novnc /usr/share/novnc
RUN mkdir /etc/nova
COPY nova.conf /etc/nova/nova.conf
COPY api-paste.ini /etc/nova/api-paste.ini
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["api"]

