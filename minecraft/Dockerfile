FROM openjdk:16-jdk-slim

ENV VERSION=1.17 \
    TZ=UTC

RUN apt update && apt install -y wget git && apt clean \
    && mkdir /minecraft && cd /minecraft \
    && wget --progress=bar:force "https://launcher.mojang.com/v1/objects/0a269b5f2c5b93b1712d0f5dc43b6182b9ab254e/server.jar" \
    && echo eula=true > eula.txt

RUN cd /tmp \
    && wget --progress=bar:force "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" \
    && java -jar BuildTools.jar --rev ${VERSION} \
    && java -jar BuildTools.jar --rev ${VERSION} --compile craftbukkit \
    && mv spigot-${VERSION}.jar /minecraft/spigot.jar \
    && mv craftbukkit-${VERSION}.jar /minecraft/craftbukkit.jar \
    && rm -Rf /tmp/* /var/tmp/*

RUN mkdir /minecraft/plugins && cd /minecraft/plugins \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3283/695/worldedit-bukkit-7.2.5-dist.jar" \
    && cd /minecraft/plugins \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3342/964/worldguard-bukkit-7.0.5-dist.jar" \
    && cd /minecraft/plugins \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3362/854/Multiverse-Core-4.3.0.jar" \
    && cd /minecraft/plugins \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3113/114/Multiverse-Portals-4.2.1.jar" \
    && cd /minecraft/plugins \
    && wget --progress=bar:force "https://media.forgecdn.net/files/2744/510/LaggRemover-2.0.6.jar" \
    && cd /minecraft/plugins \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3242/277/Dynmap-3.1-spigot.jar" \
    && cd /minecraft/plugins \
    && wget --progress=bar:force "https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/734/artifact/bootstrap/bungeecord/target/Geyser-BungeeCord.jar"

EXPOSE 25565 19132/udp

VOLUME [ "/minecraft/world", "/minecraft/world_nether", "/minecraft/world_the_end" ]

WORKDIR /minecraft

ENTRYPOINT [ "java", "-XX:+UseContainerSupport", "-XX:+UseG1GC", "-XX:+ParallelRefProcEnabled", "-XX:MaxGCPauseMillis=200", "-XX:+UnlockExperimentalVMOptions", "-XX:+DisableExplicitGC", "-XX:+AlwaysPreTouch", "-XX:G1NewSizePercent=60", "-XX:G1MaxNewSizePercent=80", "-XX:G1HeapRegionSize=8M", "-XX:G1ReservePercent=20", "-XX:G1HeapWastePercent=5", "-XX:G1MixedGCCountTarget=4", "-XX:InitiatingHeapOccupancyPercent=15", "-XX:G1MixedGCLiveThresholdPercent=90", "-XX:G1RSetUpdatingPauseTimePercent=5", "-XX:SurvivorRatio=32", "-XX:+PerfDisableSharedMem", "-XX:MaxTenuringThreshold=1", "-Dusing.aikars.flags=https://mcflags.emc.gs", "-Daikars.new.flags=true", "-jar", "/minecraft/spigot.jar", "nogui" ]
