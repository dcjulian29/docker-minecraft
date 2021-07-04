FROM openjdk:16-jdk-slim

ENV TZ=UTC

RUN apt update && apt install -y wget git && apt clean \
    && mkdir /minecraft && cd /minecraft \
    && wget --progress=bar:force "https://launcher.mojang.com/v1/objects/0a269b5f2c5b93b1712d0f5dc43b6182b9ab254e/server.jar" \
    && echo eula=true > eula.txt

EXPOSE 25565

VOLUME [ "/minecraft/world" ]

WORKDIR /minecraft

ENTRYPOINT [ "java", "-XX:InitialRAMPercentage=75", "-XX:MinRAMPercentage=75", "-XX:MaxRAMPercentage=75", "-XshowSettings:vm", "-jar", "/minecraft/server.jar", "nogui" ]
