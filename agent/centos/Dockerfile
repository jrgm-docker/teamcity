FROM centos:centos7

MAINTAINER John Morrison <jrgm@mozilla.com>

COPY scripts/supervisord /etc/
COPY scripts /scripts

# `nave` requires me to fake this command now
COPY scripts/shasum /usr/bin/shasum
RUN chmod ugo+x /usr/bin/shasum

RUN /scripts/common.sh
RUN /scripts/configure.sh

CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]
