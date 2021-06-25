FROM ubuntu:latest

ENV TZ        UTC
ENV VERSION   1.17.2.01
ENV LD_LIBRARY_PATH /minecraft

RUN apt update && apt dist-upgrade -y && apt install wget unzip -y

RUN mkdir /minecraft && cd /minecraft \
    && wget --progress=bar:force "https://minecraft.azureedge.net/bin-linux/bedrock-server-${VERSION}.zip" \
    && unzip bedrock-server-${VERSION}.zip \
    && rm bedrock-server-${VERSION}.zip \
    && chmod 755 /minecraft/bedrock_server

EXPOSE 19132/udp

VOLUME [ "/minecraft/worlds" ]

WORKDIR /minecraft

ENTRYPOINT [ "/minecraft/bedrock_server" ]
