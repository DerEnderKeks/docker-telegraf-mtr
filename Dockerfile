FROM alpine:latest AS builder

RUN apk add --no-cache alpine-sdk automake autoconf

RUN mkdir -p /tmp/mtr
WORKDIR /tmp/mtr
RUN git clone https://github.com/traviscross/mtr .
RUN ./bootstrap.sh && ./configure && make


### Final image

FROM telegraf:alpine
LABEL maintainer="DerEnderKeks"

COPY --from=builder /tmp/mtr/mtr /tmp/mtr/mtr-packet /usr/sbin/

RUN apk add --no-cache dumb-init libcap 
RUN setcap cap_net_raw+ep /usr/sbin/mtr-packet
RUN apk del libcap

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/entrypoint.sh"]