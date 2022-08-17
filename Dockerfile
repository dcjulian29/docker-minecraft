FROM alpine:latest

RUN apk add wget git \
    && mkdir /minecraft && cd /minecraft \
    && wget --progress=bar:force "https://piston-data.mojang.com/v1/objects/f69c284232d7c7580bd89a5a4931c3581eae1378/server.jar" \
    && echo eula=true > eula.txt

#---------------------------------------------

FROM openjdk:19-jdk-slim
ENV TZ=UTC
WORKDIR /minecraft
COPY --from=0 /minecraft .
EXPOSE 25565
VOLUME \
    "/minecraft/banned-ips.json" \
    "/minecraft/banned-players.json" \
    "/minecraft/ops.json" \
    "/minecraft/server.properties" \
    "/minecraft/whitelist.json" \
    "/minecraft/logs" \
    "/minecraft/world"
ENTRYPOINT [ \
    "java", \
    "-XX:+UseG1GC", \
    "-XX:+ParallelRefProcEnabled", \
    "-XX:MaxGCPauseMillis=200", \
    "-XX:+UnlockExperimentalVMOptions", \
    "-XX:+DisableExplicitGC", \
    "-XX:+AlwaysPreTouch", \
    "-XX:G1NewSizePercent=30", \
    "-XX:G1MaxNewSizePercent=40", \
    "-XX:G1HeapRegionSize=8M", \
    "-XX:G1ReservePercent=20", \
    "-XX:G1HeapWastePercent=5", \
    "-XX:G1MixedGCCountTarget=4", \
    "-XX:G1HeapWastePercent=5", \
    "-XX:G1MixedGCCountTarget=4", \
    "-XX:InitiatingHeapOccupancyPercent=15", \
    "-XX:G1MixedGCLiveThresholdPercent=90", \
    "-XX:G1RSetUpdatingPauseTimePercent=5", \
    "-XX:SurvivorRatio=32", \
    "-XX:+PerfDisableSharedMem", \
    "-XX:MaxTenuringThreshold=1", \
    "-Dusing.aikars.flags=https://mcflags.emc.gs", \
    "-Daikars.new.flags=true", \
    "-XX:InitialRAMPercentage=75", \
    "-XX:MinRAMPercentage=75", \
    "-XX:MaxRAMPercentage=75", \
    "-XshowSettings:vm", \
    "-jar", \
    "/minecraft/server.jar", \
    "--nogui" ]
HEALTHCHECK --interval=30s \
            --timeout=5s \
            --start-period=10s \
            --retries=3 \
            CMD [ "perl -MIO::Socket -e '\$socket=IO::Socket::INET->new(Proto=>tcp,PeerAddr=>\"127.0.0.1\",PeerPort=>25565);if(\$@) { exit(1) } else { exit(0) }'" ]
