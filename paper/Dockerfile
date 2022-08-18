FROM alpine:latest

RUN apk add wget \
    && mkdir /minecraft && cd /minecraft \
    && wget -nv "https://papermc.io/api/v2/projects/paper/versions/1.18/builds/42/downloads/paper-1.18-42.jar" \
        -O paper.jar \
    && mkdir /minecraft/plugins && cd /minecraft/plugins \
    && wget -nv "https://mediafiles.forgecdn.net/files/3922/624/worldedit-bukkit-7.2.12.jar" \
    && wget -nv "https://mediafiles.forgecdn.net/files/3677/516/worldguard-bukkit-7.0.7-dist.jar" \
    && wget -nv "https://mediafiles.forgecdn.net/files/3462/546/Multiverse-Core-4.3.1.jar" \
    && wget -nv "https://mediafiles.forgecdn.net/files/3113/114/Multiverse-Portals-4.2.1.jar" \
    && wget -nv "https://mediafiles.forgecdn.net/files/3687/506/Multiverse-NetherPortals-4.2.2.jar" \
    && wget -nv "https://mediafiles.forgecdn.net/files/3074/605/Multiverse-SignPortals-4.2.0.jar" \
    && wget -nv "https://mediafiles.forgecdn.net/files/3934/649/Dynmap-3.4-spigot.jar" \
    && wget -nv "https://mediafiles.forgecdn.net/files/2843/593/Dynmap-WorldGuard-1.2.jar" \
    && wget -nv "https://mediafiles.forgecdn.net/files/3680/816/DriveBackupV2.jar" \
    && wget -nv "https://mediafiles.forgecdn.net/files/3695/832/DiscordSRV-Build-1.25.1.jar" \
    && wget -nv "https://mediafiles.forgecdn.net/files/3933/49/PvPManager.jar" \
    && wget -nv "https://ci.opencollab.dev//job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar"

#---------------------------------------------

FROM dcjulian29/minecraft:latest
COPY --from=0 /minecraft/plugins /minecraft/plugins
COPY --from=0 /minecraft/paper.jar /minecraft/
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
