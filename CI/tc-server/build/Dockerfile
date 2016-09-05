FROM local/jre

ENV TEAMCITY_VERSION 10.0.1
ENV TEAMCITY_DATA_PATH /var/lib/teamcity

RUN apk --no-cache add tzdata && \
  cp /usr/share/zoneinfo/Europe/Brussels /etc/localtime && \
  echo "Europe/Brussels" >  /etc/timezone && \
  apk del tzdata && \
  mkdir -p /opt && \
  curl --insecure -sLo- https://download.jetbrains.com/teamcity/TeamCity-$TEAMCITY_VERSION.tar.gz | tar xz -C /opt && \
  sed -i -e "s/\.*<\/Host>.*$/<Valve className=\"org.apache.catalina.valves.RemoteIpValve\" protocolHeader=\"x-forwarded-proto\" \/><\/Host>/" /opt/TeamCity/conf/server.xml

COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE  8111

VOLUME /var/lib/teamcity

CMD ["/docker-entrypoint.sh"]
