@echo off
setlocal
pushd %~dp0

IF exist .docker ( echo .docker exists ) ELSE ( mkdir .docker && echo .docker created)

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
echo --------------------------------------------------------------------------------
docker image inspect dcjulian29/minecraft:%VERSION%
docker image inspect dcjulian29/minecraft:%VERSION% > .docker\minecraft_%VERSION%.json
echo --------------------------------------------------------------------------------

pushd paper
echo.
echo *
echo * Paper Build (%VERSION%)
echo *
echo.
docker build --progress plain -t dcjulian29/minecraft:%VERSION%-paper .
docker tag dcjulian29/minecraft:%VERSION%-paper dcjulian29/minecraft:latest-paper
popd
echo --------------------------------------------------------------------------------
docker image inspect dcjulian29/minecraft:%VERSION%-paper
docker image inspect dcjulian29/minecraft:%VERSION%-paper > .docker\minecraft_%VERSION%-paper.json
echo --------------------------------------------------------------------------------

pushd spigot
echo.
echo *
echo * Spigot Build (%VERSION%)
echo *
echo.
docker build --progress plain -t dcjulian29/minecraft:%VERSION%-spigot .
docker tag dcjulian29/minecraft:%VERSION%-spigot dcjulian29/minecraft:latest-spigot
popd
echo --------------------------------------------------------------------------------
docker image inspect dcjulian29/minecraft:%VERSION%-spigot
docker image inspect dcjulian29/minecraft:%VERSION%-spigot > .docker\minecraft_%VERSION%-spigot.json
echo --------------------------------------------------------------------------------

pushd bedrock
echo.
echo *
echo * Bedrock Build (%BEDROCK%)
echo *
echo.
docker build --no-cache --progress plain -t dcjulian29/bedrock:%BEDROCK% .
docker tag dcjulian29/bedrock:%BEDROCK% dcjulian29/bedrock:latest
popd
echo --------------------------------------------------------------------------------
docker image inspect dcjulian29/bedrock:%BEDROCK%
docker image inspect dcjulian29/bedrock:%BEDROCK% > .docker\bedrock_%BEDROCK%.json
echo --------------------------------------------------------------------------------

pushd bungeecord
echo.
echo *
echo * BungeeCord Build (%BUNGEECORD%)
echo *
echo.
docker build --no-cache --progress plain -t dcjulian29/bungeecord:%BUNGEECORD% .
docker tag dcjulian29/bungeecord:%BUNGEECORD% dcjulian29/bungeecord:latest
popd
echo --------------------------------------------------------------------------------
docker image inspect dcjulian29/bungeecord:%BUNGEECORD%
docker image inspect dcjulian29/bungeecord:%BUNGEECORD% > .docker\bungeecord_%BUNGEECORD%.json
echo --------------------------------------------------------------------------------

popd
endlocal
