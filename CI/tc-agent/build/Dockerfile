FROM local/jre

USER root

ADD setup-agent.sh /setup-agent.sh

RUN \
    apk --no-cache add procps sudo && \
    adduser -D teamcity && \
    mkdir -p /etc/sudoers.d && \
    echo "teamcity ALL=NOPASSWD: ALL" >> /etc/sudoers.d/teamcity && \
    echo "Defaults:teamcity !requiretty" >> /etc/sudoers.d/teamcity && \
    rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Brussels /etc/localtime && \
    echo "Europe/Brussels" > /etc/timezone 

USER teamcity
WORKDIR /home/teamcity

EXPOSE 9090

ENTRYPOINT ["tini","-g","--","/setup-agent.sh"]
CMD ["run"]
