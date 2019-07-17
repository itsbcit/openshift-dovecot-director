FROM bcit/openshift-dovecot:2.3.6-r0
# vim: syntax=dockerfile

LABEL maintainer="jesse_weisner@bcit.ca, Juraj Ontkanin"
LABEL version="2.3.6-r0"


RUN apk --no-cache update \
 && apk --no-cache add \
    perl \
    perl-io-socket-inet6 \
    perl-io-socket-ssl

WORKDIR /tmp

RUN wget https://raw.githubusercontent.com/brandond/poolmon/0.6/poolmon \
 && mv poolmon /usr/sbin/ \
 && chmod 755 /usr/sbin/poolmon

WORKDIR /var/lib/dovecot

COPY supervisor-dovecot.conf /etc/supervisor/conf.d/

CMD ["supervisord", "-c", "/etc/supervisor.conf"]
