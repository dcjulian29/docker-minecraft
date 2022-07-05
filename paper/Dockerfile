FROM alpine:latest

RUN apk add wget
RUN mkdir -p /minecraft/plugins

WORKDIR /minecraft/plugins

RUN wget "https://api.papermc.io/v2/projects/paper/versions/1.19/builds/50/downloads/paper-1.19-50.jar" -O /minecraft/paper.jar

#---------------------------------------------

RUN wget "https://mediafiles.forgecdn.net/files/3697/296/worldedit-bukkit-7.2.10.jar"
RUN wget "https://mediafiles.forgecdn.net/files/3677/516/worldguard-bukkit-7.0.7-dist.jar"
RUN wget "https://mediafiles.forgecdn.net/files/3462/546/Multiverse-Core-4.3.1.jar"
RUN wget "https://mediafiles.forgecdn.net/files/3113/114/Multiverse-Portals-4.2.1.jar"
RUN wget "https://mediafiles.forgecdn.net/files/3687/506/Multiverse-NetherPortals-4.2.2.jar"
RUN wget "https://mediafiles.forgecdn.net/files/3074/605/Multiverse-SignPortals-4.2.0.jar"
RUN wget "https://mediafiles.forgecdn.net/files/3637/280/Dynmap-3.3.2-spigot.jar"
RUN wget "https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar"

#---------------------------------------------

FROM dcjulian29/minecraft:latest
COPY --from=0 /minecraft/ /minecraft/
EXPOSE 8123 25565 19132/udp
VOLUME \
    "/minecraft/bukkit.yml" \
    "/minecraft/spigot.yml" \
    "/minecraft/paper.yml" \
    "/minecraft/world_nether" \
    "/minecraft/world_the_end" \
    "/minecraft/plugins/dynmap/web/tiles"
ENTRYPOINT [ \
    "java", \
    "-XX:InitialRAMPercentage=75", \
    "-XX:MinRAMPercentage=75", \
    "-XX:MaxRAMPercentage=75", \
    "-XshowSettings:vm", \
    "-XX:+UnlockExperimentalVMOptions", \
    "-XX:+UseG1GC", \
    "-XX:+AlwaysPreTouch", \
    "-XX:+DisableExplicitGC", \
    "-XX:G1MaxNewSizePercent=40", \
    "-XX:G1NewSizePercent=30", \
    "-XX:G1MixedGCCountTarget=4", \
    "-XX:G1MixedGCLiveThresholdPercent=90", \
    "-XX:G1HeapRegionSize=8M", \
    "-XX:G1HeapWastePercent=5", \
    "-XX:G1ReservePercent=20", \
    "-XX:G1RSetUpdatingPauseTimePercent=5", \
    "-XX:InitiatingHeapOccupancyPercent=15", \
    "-XX:MaxGCPauseMillis=200", \
    "-XX:MaxTenuringThreshold=1", \
    "-XX:+ParallelRefProcEnabled", \
    "-XX:+PerfDisableSharedMem", \
    "-XX:SurvivorRatio=32", \
    "-jar", \
    "/minecraft/paper.jar", \
    "nogui" \
    ]
HEALTHCHECK --interval=30s \
            --timeout=5s \
            --start-period=10s \
            --retries=3 \
            CMD [ "perl -MIO::Socket -e '\$socket=IO::Socket::INET->new(Proto=>tcp,PeerAddr=>\"127.0.0.1\",PeerPort=>25565);if(\$@) { exit(1) } else { exit(0) }'" ]
