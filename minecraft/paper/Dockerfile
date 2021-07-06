FROM alpine:latest

RUN apk add wget \
    && mkdir /minecraft && cd /minecraft \
    && wget --progress=bar:force "https://papermc.io/api/v2/projects/paper/versions/1.17/builds/75/downloads/paper-1.17-75.jar" -O paper.jar \
    && mkdir /minecraft/plugins && cd /minecraft/plugins \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3283/695/worldedit-bukkit-7.2.5-dist.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3342/964/worldguard-bukkit-7.0.5-dist.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3362/854/Multiverse-Core-4.3.0.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/3113/114/Multiverse-Portals-4.2.1.jar" \
    && wget --progress=bar:force "https://media.forgecdn.net/files/2744/510/LaggRemover-2.0.6.jar" \
    && wget --progress=bar:force "https://dynmap.us/releases/Dynmap-3.2-beta-2-spigot.jar" \
    && wget --progress=bar:force "https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/744/artifact/bootstrap/spigot/target/Geyser-Spigot.jar"

#---------------------------------------------

FROM dcjulian29/minecraft:latest
COPY --from=0 /minecraft/plugins/*.jar ./plugins/
COPY --from=0 /minecraft/paper.jar ./
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
    "-jar", \
    "/minecraft/paper.jar", \
    "nogui" \
    ]
