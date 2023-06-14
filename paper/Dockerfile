FROM alpine:latest

ARG VERSION
ARG BUILD

RUN apk add wget \
    && wget -nv "https://api.papermc.io/v2/projects/paper/versions/${VERSION}/builds/${BUILD}/downloads/paper-${VERSION}-${BUILD}.jar" \
        -O /paper.jar

#---------------------------------------------

FROM dcjulian29/minecraft:latest

RUN mkdir /minecraft/plugins

COPY --from=0 /paper.jar /minecraft/

EXPOSE 25565

VOLUME \
    "/minecraft/bukkit.yml" \
    "/minecraft/spigot.yml" \
    "/minecraft/config" \
    "/minecraft/plugins" \
    "/minecraft/world_nether" \
    "/minecraft/world_the_end"

ENV JAR_FILE=paper.jar

ENTRYPOINT [ "/docker-entrypoint.sh" ]

HEALTHCHECK --interval=30s \
            --timeout=5s \
            --start-period=10s \
            --retries=3 \
            CMD [ "perl -MIO::Socket -e '\$socket=IO::Socket::INET->new(Proto=>tcp,PeerAddr=>\"127.0.0.1\",PeerPort=>25565);if(\$@) { exit(1) } else { exit(0) }'" ]
