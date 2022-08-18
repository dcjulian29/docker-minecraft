@echo off
setlocal

pushd %~dp0

IF exist .docker ( echo .docker exists ) ELSE ( mkdir .docker && echo .docker created)

for /f "delims=" %%x in (VERSION) do set VERSION=%%x
for /f "delims=" %%x in (VERSION_BEDROCK) do set BEDROCK=%%x
for /f "delims=" %%x in (VERSION_BUNGEECORD) do set BUNGEECORD=%%x

echo.
echo *
echo * Vanilla Build (%VERSION%)
echo *
echo.

docker build -t dcjulian29/minecraft:%VERSION% .

if %errorlevel% neq 0 goto FINAL

docker tag dcjulian29/minecraft:%VERSION% dcjulian29/minecraft:latest
docker image inspect dcjulian29/minecraft:%VERSION% > .docker\minecraft_%VERSION%.json

echo.
echo *
echo * Paper Build (%VERSION%)
echo *
echo.

docker build -t dcjulian29/minecraft:%VERSION%-paper .

if %errorlevel% neq 0 goto FINAL

docker tag dcjulian29/minecraft:%VERSION%-paper dcjulian29/minecraft:latest-paper
docker image inspect dcjulian29/minecraft:%VERSION%-paper > .docker\minecraft_%VERSION%-paper.json

pushd spigot
echo.
echo *
echo * Spigot Build (%VERSION%)
echo *
echo.

docker build --build-arg VERSION=%VERSION% -t dcjulian29/minecraft:%VERSION%-spigot .

if %errorlevel% neq 0 goto FINAL

docker tag dcjulian29/minecraft:%VERSION%-spigot dcjulian29/minecraft:latest-spigot
docker image inspect dcjulian29/minecraft:%VERSION%-spigot > .docker\minecraft_%VERSION%-spigot.json

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

:FINAL

popd

endlocal
