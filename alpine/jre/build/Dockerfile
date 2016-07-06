FROM local/alpine:3.4

# Define java version properties
# -----------------------------------------------------------------------------
ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=74 \
    JAVA_VERSION_BUILD=02 \
    JAVA_PACKAGE=server-jre \
    LANG=C.UTF-8

RUN set -e && \
    apk --update add --virtual build-dependencies wget ca-certificates && \

    GLIBC_URL="https://github.com/andyshinn/alpine-pkg-glibc/releases/download" && \
    GLIBC_PKG_VERSION="2.23-r1" && \
    GLIBC_PKG_FILE="glibc-${GLIBC_PKG_VERSION}.apk" && \
    GLIBC_BIN_PKG_FILE="glibc-bin-${GLIBC_PKG_VERSION}.apk" && \
    GLIBC_I18N_PKG_FILE="glibc-i18n-${GLIBC_PKG_VERSION}.apk" && \
    GLIBC_BASE="${GLIBC_URL}/${GLIBC_PKG_VERSION}" && \

    wget --quiet --no-check-certificate \
      "${GLIBC_URL}/${GLIBC_PKG_VERSION}/${GLIBC_PKG_FILE}" \
      "${GLIBC_URL}/${GLIBC_PKG_VERSION}/${GLIBC_BIN_PKG_FILE}" \
      "${GLIBC_URL}/${GLIBC_PKG_VERSION}/${GLIBC_I18N_PKG_FILE}" && \

    apk add --no-cache --allow-untrusted \
        "${GLIBC_PKG_FILE}" \
        "${GLIBC_BIN_PKG_FILE}" \
        "${GLIBC_I18N_PKG_FILE}" && \

    /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 ${LANG} || true && \
    echo "export LANG=${LANG}" > /etc/profile.d/locale.sh && \

    apk del glibc-i18n && \
    apk del build-dependencies && \
    rm -rf "$GLIBC_PKG_FILE" \
          "$GLIBC_BIN_PKG_FILE" \
          "$GLIBC_I18N_PKG_FILE" \
          /var/cache/* && \

    cd /tmp && \
    curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie"\
    http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz | gunzip -c - | tar -xf - && \

    mv jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/jre /jre && \
    rm /jre/bin/jjs && \
    rm /jre/bin/keytool && \
    rm /jre/bin/orbd && \
    rm /jre/bin/pack200 && \
    rm /jre/bin/policytool && \
    rm /jre/bin/rmid && \
    rm /jre/bin/rmiregistry && \
    rm /jre/bin/servertool && \
    rm /jre/bin/tnameserv && \
    rm /jre/bin/unpack200 && \
    rm /jre/lib/ext/nashorn.jar && \
    rm /jre/lib/jfr.jar && \
    rm -f /jre/lib/fontconfig* && \
    rm -rf /jre/lib/fonts && \
    rm -rf /jre/lib/jfr && \
    rm -rf /jre/lib/oblique-fonts && \
    rm -rf /jre/lib/images && \
    rm -rf /tmp/* /var/cache/apk/* && \

    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

ENV JAVA_HOME /jre
ENV PATH ${PATH}:${JAVA_HOME}/bin

ENTRYPOINT [ "tini","-g","--" ]
CMD [ "$@" ]
