FROM ubuntu:focal

ARG PRITUNL_VERSION="1.29.2468.79"
ENV PRITUNL_VERSION=${PRITUNL_VERSION}

LABEL MAINTAINER="Marcus Young <myoung34@my.apsu.edu>"

RUN apt-get update -q && \
  apt-get install -y ca-certificates gnupg && \
  echo 'deb https://repo.pritunl.com/stable/apt focal main' > /etc/apt/sources.list.d/pritunl.list && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A && \
  apt-get update -q && \
  apt-get install -y \
    locales \
    iptables \
    wget \
    gnupg \
    ca-certificates \
    python2 \
    net-tools \
    pritunl \
    mongodb-clients \
    psmisc && \
  rm -rf /var/lib/apt/lists/*

COPY plugins /var/lib/pritunl/plugins
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
COPY mongo-attach-all.js /

EXPOSE 80
EXPOSE 443
EXPOSE 1194
EXPOSE 1194/udp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/tail", "-f","/var/log/pritunl_journal.log"]
