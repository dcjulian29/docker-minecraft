@echo off
setlocal

::docker scan dcjulian29/minecraft:latest
::docker scan dcjulian29/minecraft:latest-vanilla
::docker scan dcjulian29/minecraft:latest-bedrock
::docker scan dcjulian29/bungeecord:latest

docker push dcjulian29/minecraft  --all-tags
docker push dcjulian29/bungeecord --all-tags

endlocal
