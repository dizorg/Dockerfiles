FROM vbatts/slackware-base

RUN sed -i -e "/^#.*http.*osuosl.*current/ s/^#//" /etc/slackpkg/mirrors  \
 && slackpkg update \
 && slackpkg install git make gcc libffi-3.2.1-x86_64-1 gc-7.4.2-x86_64-3 guile-2.0.11-x86_64-2 libunistring-0.9.3-x86_64-1 dev86-0.16.21-x86_64-1 libmpc-1.0.3-x86_64 binutils-2.26-x86_64-3 glibc-2.23

