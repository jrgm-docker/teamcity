FROM centos:centos7

MAINTAINER John Morrison <jrgm@mozilla.com>

COPY scripts/supervisord /etc/
COPY scripts /scripts

RUN /scripts/common.sh
RUN /scripts/configure.sh

CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]
