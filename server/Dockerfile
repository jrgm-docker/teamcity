
FROM centos:centos7

MAINTAINER John Morrison <jrgm@mozilla.com>

# TeamCity data is stored in a volume to facilitate container upgrade
VOLUME  ["/data/teamcity"]
ENV TEAMCITY_DATA_PATH /data/teamcity
ENV TEAMCITY_PACKAGE TeamCity-9.1.7.tar.gz
ENV TEAMCITY_DOWNLOAD https://download.jetbrains.com/teamcity

COPY scripts /scripts
RUN /scripts/common.sh

# Download and install TeamCity to /opt
RUN wget --no-verbose $TEAMCITY_DOWNLOAD/$TEAMCITY_PACKAGE && \
  tar zxf $TEAMCITY_PACKAGE -C /opt && \
  rm -rf $TEAMCITY_PACKAGE

CMD ["/opt/TeamCity/bin/teamcity-server.sh", "run"]
