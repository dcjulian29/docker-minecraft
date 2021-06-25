FROM openjdk:16-jdk-slim

ENV TZ=UTC

RUN apt update && apt install -y wget && apt clean \
    && mkdir /minecraft && cd /minecraft \
    && wget --progress=bar:force "https://ci.md-5.net/job/BungeeCord/1585/artifact/bootstrap/target/BungeeCord.jar"

EXPOSE 25565

VOLUME [ "/minecraft/config.yml" ]

WORKDIR /minecraft

ENTRYPOINT [ "java", "-XX:+UseG1GC", "-XX:+ParallelRefProcEnabled", "-XX:MaxGCPauseMillis=200", "-XX:+UnlockExperimentalVMOptions", "-XX:+DisableExplicitGC", "-XX:+AlwaysPreTouch", "-XX:G1NewSizePercent=60", "-XX:G1MaxNewSizePercent=80", "-XX:G1HeapRegionSize=8M", "-XX:G1ReservePercent=20", "-XX:G1HeapWastePercent=5", "-XX:G1MixedGCCountTarget=4", "-XX:InitiatingHeapOccupancyPercent=15", "-XX:G1MixedGCLiveThresholdPercent=90", "-XX:G1RSetUpdatingPauseTimePercent=5", "-XX:SurvivorRatio=32", "-XX:+PerfDisableSharedMem", "-XX:MaxTenuringThreshold=1", "-Dusing.aikars.flags=https://mcflags.emc.gs", "-Daikars.new.flags=true", "-jar", "/minecraft/BungeeCord.jar" ]
