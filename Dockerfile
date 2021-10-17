FROM alpine:3.14

RUN apk add openjdk16-jre --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  && addgroup -g 1000 -S minecraft \
  && adduser -u 1000 -HD -G minecraft minecraft \
  && mkdir -m 755 -p /fabric \
  && chown minecraft:minecraft /fabric

WORKDIR /fabric
COPY --chown=minecraft:minecraft scripts/bootstrap.sh /fabric/bootstrap.sh
EXPOSE 25565
USER minecraft
ENTRYPOINT [ "/fabric/bootstrap.sh" ]
