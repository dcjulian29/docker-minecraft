FROM alpine:latest

RUN apk add wget git \
    && mkdir /minecraft && cd /minecraft \
  && wget -nv "https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar" \
    && echo eula=true > eula.txt

#---------------------------------------------

FROM eclipse-temurin:22-jre

WORKDIR /minecraft

COPY --from=0 /minecraft .

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apt-get update \
  && apt-get install -y gosu \
  && chmod 755 /docker-entrypoint.sh \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

EXPOSE 25565

VOLUME \
    "/minecraft/banned-ips.json" \
    "/minecraft/banned-players.json" \
    "/minecraft/ops.json" \
    "/minecraft/server.properties" \
    "/minecraft/whitelist.json" \
    "/minecraft/logs" \
    "/minecraft/world"

ENV JAR_FILE=server.jar

ENTRYPOINT [ "/docker-entrypoint.sh" ]

HEALTHCHECK --interval=30s \
            --timeout=5s \
            --start-period=10s \
            --retries=3 \
            CMD [ "perl -MIO::Socket -e '\$socket=IO::Socket::INET->new(Proto=>tcp,PeerAddr=>\"127.0.0.1\",PeerPort=>25565);if(\$@) { exit(1) } else { exit(0) }'" ]
