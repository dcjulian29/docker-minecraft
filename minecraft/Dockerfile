FROM alpine:latest

ENV TZ        UTC

RUN apk update && apk add openjdk11-jre git \
    && rm -rf /var/cache/apk/*

RUN mkdir /minecraft && cd /minecraft \
    && wget "https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar" \
    && echo eula=true > eula.txt \
    && mkdir /minecraft/plugins

ENV VERSION   1.16.5

RUN cd /tmp \
    && wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar \
    && java -jar BuildTools.jar --rev ${VERSION} \
    && java -jar BuildTools.jar --rev ${VERSION} --compile craftbukkit \
    && mv spigot-${VERSION}.jar /minecraft/spigot.jar \
    && mv craftbukkit-${VERSION}.jar /minecraft/craftbukkit.jar \
    && rm -Rf /tmp/* /var/tmp/*

RUN cd /minecraft/plugins \
    && wget https://media.forgecdn.net/files/3283/695/worldedit-bukkit-7.2.5-dist.jar

RUN cd /minecraft/plugins \
    && wget https://media.forgecdn.net/files/3066/271/worldguard-bukkit-7.0.4.jar

RUN cd /minecraft/plugins \
    && wget https://media.forgecdn.net/files/3074/594/Multiverse-Core-4.2.2.jar

RUN cd /minecraft/plugins \
    && wget https://media.forgecdn.net/files/3113/114/Multiverse-Portals-4.2.1.jar

RUN cd /minecraft/plugins \
    && wget https://media.forgecdn.net/files/2744/510/LaggRemover-2.0.6.jar

RUN cd /minecraft/plugins \
    && wget https://media.forgecdn.net/files/3242/277/Dynmap-3.1-spigot.jar

RUN cd /minecraft/plugins \
    && wget https://ci.opencollab.dev//job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar

EXPOSE 25565 19132/udp

VOLUME [ "/minecraft/world", "/minecraft/world_nether", "/minecraft/world_the_end" ]

WORKDIR /minecraft

ENTRYPOINT [ "java", "-XX:+UseCGroupMemoryLimitForHeap", "-XX:+UseG1GC", "-XX:+ParallelRefProcEnabled", "-XX:MaxGCPauseMillis=200", "-XX:+UnlockExperimentalVMOptions", "-XX:+DisableExplicitGC", "-XX:+AlwaysPreTouch", "-XX:G1NewSizePercent=60", "-XX:G1MaxNewSizePercent=80", "-XX:G1HeapRegionSize=8M", "-XX:G1ReservePercent=20", "-XX:G1HeapWastePercent=5", "-XX:G1MixedGCCountTarget=4", "-XX:InitiatingHeapOccupancyPercent=15", "-XX:G1MixedGCLiveThresholdPercent=90", "-XX:G1RSetUpdatingPauseTimePercent=5", "-XX:SurvivorRatio=32", "-XX:+PerfDisableSharedMem", "-XX:MaxTenuringThreshold=1", "-Dusing.aikars.flags=https://mcflags.emc.gs", "-Daikars.new.flags=true", "-jar", "/minecraft/spigot.jar", "nogui" ]
