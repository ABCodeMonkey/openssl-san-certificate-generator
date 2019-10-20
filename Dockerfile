FROM alpine

RUN apk update                 && \
    apk add --no-cache bash    && \
    apk add --no-cache openssl && \
    rm -rf /var/cache/apk/*

WORKDIR /build

ADD . .

RUN mkdir -p /export

ENTRYPOINT ./build.sh

