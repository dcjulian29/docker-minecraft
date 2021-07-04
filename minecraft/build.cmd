@echo off
setlocal
pushd %~dp0

set VERSION=1.17.0
set BEDROCK=1.17.2.01
set BUNGEECORD=1.5.85

echo.
echo *
echo * Vanilla Build (%VERSION%)
echo *
echo.

docker build --no-cache --progress plain -t dcjulian29/minecraft:%VERSION% .
docker tag dcjulian29/minecraft:%VERSION% dcjulian29/minecraft:latest

pushd paper
echo.
echo *
echo * Paper Build (%VERSION%)
echo *
echo.

docker build --progress plain -t dcjulian29/minecraft:%VERSION%-paper .
docker tag dcjulian29/minecraft:%VERSION%-paper dcjulian29/minecraft:latest-paper
popd

pushd spigot
echo.
echo *
echo * Spigot Build (%VERSION%)
echo *
echo.

docker build --progress plain -t dcjulian29/minecraft:%VERSION%-spigot .
docker tag dcjulian29/minecraft:%VERSION%-spigot dcjulian29/minecraft:latest-spigot
popd

pushd bedrock
echo.
echo *
echo * Bedrock Build (%BEDROCK%)
echo *
echo.

docker build --no-cache --progress plain -t dcjulian29/bedrock:%BEDROCK% .
docker tag dcjulian29/bedrock:%BEDROCK% dcjulian29/bedrock:latest
popd

pushd bungeecord
echo.
echo *
echo * BungeeCord Build (%BUNGEECORD%)
echo *
echo.

docker build --no-cache --progress plain -t dcjulian29/bungeecord:%BUNGEECORD% .
docker tag dcjulian29/bungeecord:%BUNGEECORD% dcjulian29/bungeecord:latest
popd

popd
endlocal
