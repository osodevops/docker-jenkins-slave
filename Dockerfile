FROM jenkinsci/jnlp-slave:3.27-1
MAINTAINER sion@osodevops.io

USER root

RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates \
    && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo deb https://apt.dockerproject.org/repo debian-jessie main >> /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-engine \
    && apt-get install -y btrfs-tools \
    && rm -rf /var/lib/apt/lists/*

ADD start-slave.sh /root/

RUN echo "jenkins    ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

ENTRYPOINT ["/root/launch-slave.sh"]