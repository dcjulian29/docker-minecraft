FROM eclipse-temurin:22-jdk

ARG VERSION

RUN apt update && apt install -y wget git

RUN mkdir /minecraft && cd /tmp \
    && wget -nv "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" \
    && java -jar BuildTools.jar --rev ${VERSION} \
    && java -jar BuildTools.jar --rev ${VERSION} --compile craftbukkit \
    && mv spigot-${VERSION}.jar /minecraft/spigot.jar \
    && mv craftbukkit-${VERSION}.jar /minecraft/craftbukkit.jar

#---------------------------------------------

FROM dcjulian29/minecraft:latest

RUN mkdir /minecraft/plugins

COPY --from=0 /minecraft/spigot.jar /minecraft/craftbukkit.jar /minecraft/

EXPOSE 25565

VOLUME \
    "/minecraft/bukkit.yml" \
    "/minecraft/spigot.yml" \
    "/minecraft/plugins" \
    "/minecraft/world_nether" \
    "/minecraft/world_the_end"

ENV JAR_FILE=spigot.jar

ENTRYPOINT [ "/docker-entrypoint.sh" ]

HEALTHCHECK --interval=30s \
            --timeout=5s \
            --start-period=10s \
            --retries=3 \
            CMD [ "perl -MIO::Socket -e '\$socket=IO::Socket::INET->new(Proto=>tcp,PeerAddr=>\"127.0.0.1\",PeerPort=>25565);if(\$@) { exit(1) } else { exit(0) }'" ]
