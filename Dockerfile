FROM debian:stable-slim

WORKDIR /src
RUN apt-get update && apt-get upgrade \
  && apt-get install -y wget \
  && mkdir -p java \
  && wget -O jdk.tar.gz https://download.java.net/java/GA/jdk16.0.2/d4a915d82b4c4fbb9bde534da945d746/7/GPL/openjdk-16.0.2_linux-x64_bin.tar.gz  \
  && tar -zxf jdk.tar.gz -C java --strip-components 1 \
  && groupadd -g 1000 minecraft \
  && useradd -u 1000 -Mg minecraft minecraft \
  && chown minecraft:minecraft /src

ENV PATH="/src/java/bin:${PATH}"
COPY --chown=minecraft:minecraft scripts/bootstrap.sh /src/bootstrap.sh
EXPOSE 25565
USER minecraft
ENTRYPOINT [ "/src/bootstrap.sh" ]
