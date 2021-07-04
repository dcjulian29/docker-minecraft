FROM openjdk:16-jdk-slim

ENV VERSION=1.17

RUN apt update && apt install -y wget git \
    && mkdir /minecraft && cd /minecraft \
    && wget --progress=bar:force "https://launcher.mojang.com/v1/objects/0a269b5f2c5b93b1712d0f5dc43b6182b9ab254e/server.jar" \
    && echo eula=true > eula.txt \
    && mkdir /minecraft/plugins && cd /minecraft/plugins \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3283/695/worldedit-bukkit-7.2.5-dist.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3342/964/worldguard-bukkit-7.0.5-dist.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3362/854/Multiverse-Core-4.3.0.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3113/114/Multiverse-Portals-4.2.1.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/2744/510/LaggRemover-2.0.6.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3242/277/Dynmap-3.1-spigot.jar" \
    && wget --progress=bar:force "https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/734/artifact/bootstrap/bungeecord/target/Geyser-BungeeCord.jar"

RUN cd /tmp \
    && wget --progress=bar:force "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" \
    && java -jar BuildTools.jar --rev ${VERSION} \
    && java -jar BuildTools.jar --rev ${VERSION} --compile craftbukkit \
    && mv spigot-${VERSION}.jar /minecraft/spigot.jar \
    && mv craftbukkit-${VERSION}.jar /minecraft/craftbukkit.jar

#---------------------------------------------

FROM openjdk:16-jdk-slim
ENV TZ=UTC
WORKDIR /minecraft
COPY --from=0 /minecraft .
EXPOSE 25565 19132/udp
VOLUME [ "/minecraft/world", "/minecraft/world_nether", "/minecraft/world_the_end" ]
ENTRYPOINT [ "java", "-XX:InitialRAMPercentage=75", "-XX:MinRAMPercentage=75", "-XX:MaxRAMPercentage=75", "-XshowSettings:vm", "-jar", "/minecraft/spigot.jar", "nogui" ]
