FROM alpine:3.4
RUN apk --no-cache add bash ca-certificates curl tini procps sudo

ENTRYPOINT ["tini","-g","--"]
CMD ["$@"]
