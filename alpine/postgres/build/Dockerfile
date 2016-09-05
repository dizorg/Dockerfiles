FROM local/alpine:3.4

ENV LANG=en_US.utf8
ENV PGDATA=/var/lib/postgresql/data

# Install build tools
#------------------------------------------------------------------------------
RUN \
    set -e && \

    GOSU="https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64" && \
    GOSU_BIN="/usr/local/bin/gosu" && \

    apk --no-cache add curl bash tini postgresql && \

    mkdir /docker-entrypoint-initdb.d && \
    curl -o ${GOSU_BIN} -sSL ${GOSU} && \
    chmod +x ${GOSU_BIN} && \

    rm -rf /var/cache/apk/* \
           /tmp/* \
           /var/log/*

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 5432
VOLUME /var/lib/postgresql/data

ENTRYPOINT [ "tini", "-g", "--", "/entrypoint.sh" ]
CMD ["$@"]
