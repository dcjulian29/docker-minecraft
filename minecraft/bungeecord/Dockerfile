FROM alpine:latest

RUN apk add wget \
    && mkdir /bungeecord && cd /bungeecord \
    && wget --progress=bar:force "https://ci.md-5.net/job/BungeeCord/1585/artifact/bootstrap/target/BungeeCord.jar"

#---------------------------------------------

FROM openjdk:16-jdk-slim
ENV TZ=UTC
WORKDIR /bungeecord
COPY --from=0 /bungeecord .
EXPOSE 25565
VOLUME [ "/bungeecord/config.yml" ]
ENTRYPOINT [ "java", "-XX:InitialRAMPercentage=75", "-XX:MinRAMPercentage=75", "-XX:MaxRAMPercentage=75", "-XshowSettings:vm", "-jar", "/bungeecord/BungeeCord.jar", "nogui" ]
