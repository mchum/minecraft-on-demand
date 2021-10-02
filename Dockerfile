FROM openjdk:16-alpine

RUN mkdir -p /fabric
COPY scripts/bootstrap.sh /fabric/bootstrap.sh

WORKDIR /fabric

EXPOSE 25565
ENTRYPOINT [ "/fabric/bootstrap.sh" ]
