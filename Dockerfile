#
# Squid HTTP Proxy for your application testing
#
# Usage:
#   docker-compose up -d
#

FROM alpine:3.10
MAINTAINER Yusuke Kawatsu "meg.mog.mog1965@gmail.com"

# Set correct environment variables.
ENV HOME /root
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# install PKGs.
RUN apk update && \
    apk --no-cache add squid libintl apache2-utils && \
    apk --no-cache add --virtual .gettext gettext && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del .gettext

# edit squid settings.
COPY squid.conf.template /etc/squid/squid.conf.template

# user.
RUN chown -R squid:squid /etc/squid/ /var/run/
USER squid

# entrypoint.
ENTRYPOINT /bin/sh -c " \
    /bin/touch /etc/squid/passwd && \
    /usr/bin/htpasswd -b /etc/squid/passwd ${BASIC_AUTH_USERNAME} ${BASIC_AUTH_PASSWORD} && \
    /usr/local/bin/envsubst < /etc/squid/squid.conf.template > /etc/squid/squid.conf && \
    /usr/sbin/squid -N -f /etc/squid/squid.conf "
