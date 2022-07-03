FROM dcjulian29/minecraft:latest

ENV VERSION=1.18

RUN apt update && apt install -y wget git

RUN cd /tmp \
    && wget --progress=bar:force "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" \
    && java -jar BuildTools.jar --rev ${VERSION} \
    && java -jar BuildTools.jar --rev ${VERSION} --compile craftbukkit \
    && mv spigot-${VERSION}.jar /minecraft/spigot.jar \
    && mv craftbukkit-${VERSION}.jar /minecraft/craftbukkit.jar \
    && mkdir /minecraft/plugins && cd /minecraft/plugins \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3502/99/worldedit-bukkit-7.2.7.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3461/546/worldguard-bukkit-7.0.6-dist.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3462/546/Multiverse-Core-4.3.1.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3113/114/Multiverse-Portals-4.2.1.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3074/616/Multiverse-NetherPortals-4.2.1.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3074/605/Multiverse-SignPortals-4.2.0.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3482/727/Dynmap-3.2.1-spigot.jar" \
    && wget --progress=bar:force "https://ci.opencollab.dev//job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar"

#---------------------------------------------

FROM dcjulian29/minecraft:latest
COPY --from=0 /minecraft/plugins /minecraft/plugins
COPY --from=0 /minecraft/spigot.jar /minecraft/craftbukkit.jar /minecraft
EXPOSE 8123 25565 19132/udp
VOLUME \
    "/minecraft/bukkit.yml" \
    "/minecraft/spigot.yml" \
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
    "/minecraft/spigot.jar", \
    "nogui" \
    ]
HEALTHCHECK --interval=30s \
            --timeout=5s \
            --start-period=10s \
            --retries=3 \
            CMD [ "perl -MIO::Socket -e '\$socket=IO::Socket::INET->new(Proto=>tcp,PeerAddr=>\"127.0.0.1\",PeerPort=>25565);if(\$@) { exit(1) } else { exit(0) }'" ]
