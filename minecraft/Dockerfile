FROM alpine:latest

ENV TZ        UTC

RUN apk update && apk add openjdk11-jre git

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
    && mv craftbukkit-${VERSION}.jar /minecraft/craftbukkit.jar

RUN cd /minecraft/plugins \
    && wget https://media.forgecdn.net/files/2869/453/worldedit-bukkit-7.1.0.jar

RUN cd /minecraft/plugins \
    && wget https://media.forgecdn.net/files/2855/477/worldguard-bukkit-7.0.2.jar

RUN cd /minecraft/plugins \
    && wget https://media.forgecdn.net/files/2768/599/Multiverse-Core-4.1.0.jar

RUN cd /minecraft/plugins \
    && wget https://media.forgecdn.net/files/2768/601/Multiverse-Portals-4.1.0.jar

RUN cd /minecraft/plugins \
    && wget https://media.forgecdn.net/files/2744/510/LaggRemover-2.0.6.jar

RUN rm -Rf /tmp/* /var/tmp/* \
    && rm -rf /var/cache/apk/*

EXPOSE 25565

VOLUME [ "/minecraft/world", "/minecraft/world_nether", "/minecraft/world_the_end" ]

WORKDIR /minecraft

ENTRYPOINT [ "java", "-Xms1024M", "-Xmx1024M", "-jar", "/minecraft/spigot.jar", "nogui" ]
