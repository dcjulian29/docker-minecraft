FROM alpine:latest

ENV VERSION   1.18.1.02

RUN apk add wget unzip \
  && mkdir /minecraft && cd /minecraft \
    && wget --progress=bar:force "https://minecraft.azureedge.net/bin-linux/bedrock-server-${VERSION}.zip" \
    && unzip bedrock-server-${VERSION}.zip \
    && rm bedrock-server-${VERSION}.zip \
    && chmod 755 /minecraft/bedrock_server

#---------------------------------------------

FROM ubuntu:latest
ENV TZ=UTC \
    LD_LIBRARY_PATH=/minecraft
WORKDIR /minecraft
COPY --from=0 /minecraft .
EXPOSE 19132/udp
VOLUME [ "/minecraft/worlds" ]
ENTRYPOINT [ "/minecraft/bedrock_server" ]
