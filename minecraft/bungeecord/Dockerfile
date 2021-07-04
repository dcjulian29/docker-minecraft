FROM openjdk:16-jdk-slim

ENV TZ=UTC

RUN apt update && apt install -y wget && apt clean \
    && mkdir /minecraft && cd /minecraft \
    && wget --progress=bar:force "https://ci.md-5.net/job/BungeeCord/1585/artifact/bootstrap/target/BungeeCord.jar"

EXPOSE 25565

VOLUME [ "/minecraft/config.yml" ]

WORKDIR /minecraft

ENTRYPOINT [ "java", "-XX:InitialRAMPercentage=75", "-XX:MinRAMPercentage=75", "-XX:MaxRAMPercentage=75", "-XshowSettings:vm", "-jar", "/minecraft/BungeeCord.jar", "nogui" ]
