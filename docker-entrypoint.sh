#!/bin/sh
set -e

DOCKER_USER='minecraft'
DOCKER_GROUP='minecraft'

if ! id "$DOCKER_USER" >/dev/null 2>&1; then
  USER_ID=${PUID:-1001}
  GROUP_ID=${PGID:-1001}

  echo "Starting with $USER_ID:$GROUP_ID (UID:GID)"

  groupadd --gid $GROUP_ID $DOCKER_GROUP
  useradd $DOCKER_USER --shell /bin/sh --uid $USER_ID -g $DOCKER_GROUP
  chown $DOCKER_USER:$DOCKER_GROUP /minecraft
  find /minecraft -type d -exec chown $USER_ID:$GROUP_ID {} +
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
