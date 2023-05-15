#!/bin/sh
set -e

DOCKER_USER='minecraft'
DOCKER_GROUP='minecraft'

if ! id "$DOCKER_USER" >/dev/null 2>&1; then
  USER_ID=${PUID:-1000}
  GROUP_ID=${PGID:-1000}

  echo "Starting with $USER_ID:$GROUP_ID (UID:GID)"

  addgroup --gid $GROUP_ID $DOCKER_GROUP
  adduser $DOCKER_USER --shell /bin/sh --uid $USER_ID --ingroup $DOCKER_GROUP \
    --disabled-password --gecos "First,Last,RoomNumber,WorkPhone,HomePhone"
  chown $DOCKER_USER:$DOCKER_GROUP /minecraft
fi

exec gosu $DOCKER_USER:$DOCKER_GROUP java \
  -XX:InitialRAMPercentage=75 \
  -XX:MinRAMPercentage=75 \
  -XX:MaxRAMPercentage=75 \
  -XshowSettings:vm \
  -XX:+UnlockExperimentalVMOptions \
  -XX:+UseG1GC \
  -XX:+AlwaysPreTouch \
  -XX:+DisableExplicitGC \
  -XX:G1MaxNewSizePercent=40 \
  -XX:G1NewSizePercent=30 \
  -XX:G1MixedGCCountTarget=4 \
  -XX:G1MixedGCLiveThresholdPercent=90 \
  -XX:G1HeapRegionSize=8M \
  -XX:G1HeapWastePercent=5 \
  -XX:G1ReservePercent=20 \
  -XX:G1RSetUpdatingPauseTimePercent=5 \
  -XX:InitiatingHeapOccupancyPercent=15 \
  -XX:MaxGCPauseMillis=200 \
  -XX:MaxTenuringThreshold=1 \
  -XX:+ParallelRefProcEnabled \
  -XX:+PerfDisableSharedMem \
  -XX:SurvivorRatio=32 \
  -jar /minecraft/$JAR_FILE \
  --nogui
