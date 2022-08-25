FROM alpine:latest

ARG VERSION

RUN apk add wget unzip \
  && mkdir /minecraft && cd /minecraft \
    && wget -nv "https://minecraft.azureedge.net/bin-linux/bedrock-server-${VERSION}.zip" \
    && unzip bedrock-server-${VERSION}.zip \
    && rm bedrock-server-${VERSION}.zip \
    && chmod 755 /minecraft/bedrock_server

#---------------------------------------------

FROM ubuntu:focal
ENV TZ=UTC \
    LD_LIBRARY_PATH=/minecraft
WORKDIR /minecraft
COPY --from=0 /minecraft .
RUN apt update && apt install -y curl
EXPOSE 19132/udp
VOLUME [ "/minecraft/worlds" ]
ENTRYPOINT [ "/minecraft/bedrock_server" ]
