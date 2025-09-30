@echo off
setlocal

pushd %~dp0

IF NOT exist .docker ( mkdir .docker)

for /f "delims=" %%x in (HASH) do set HASH=%%x
for /f "delims=" %%x in (VERSION) do set VERSION=%%x
for /f "delims=" %%x in (VERSION_PAPER) do set VERSION_PAPER=%%x

echo.
echo *
echo * Vanilla Build (%VERSION%)
echo *
echo.

docker build --progress plain --no-cache --build-arg HASH=%HASH% -t dcjulian29/minecraft:%VERSION% .

if %errorlevel% neq 0 goto FINAL

docker tag dcjulian29/minecraft:%VERSION% dcjulian29/minecraft:latest
docker image inspect dcjulian29/minecraft:%VERSION% > .docker\minecraft_%VERSION%.json

IF NOT exist .docker\banned-ips.json ( type nul > .docker\banned-ips.json )
IF NOT exist .docker\banned-players.json ( type nul > .docker\banned-players.json )
IF NOT exist .docker\ops.json ( type nul > .docker\ops.json )
IF NOT exist .docker\server.properties ( type nul > .docker\server.properties )
IF NOT exist .docker\whitelist.json ( type nul > .docker\whitelist.json )

echo.
echo *
echo * Paper Build (%VERSION%-%VERSION_PAPER%)
echo *
echo.

docker build --progress plain --no-cache --build-arg VERSION=%VERSION% --build-arg BUILD=%VERSION_PAPER% -t dcjulian29/minecraft:%VERSION%-paper paper/.

if %errorlevel% neq 0 goto FINAL

docker tag dcjulian29/minecraft:%VERSION%-paper dcjulian29/minecraft:latest-paper
docker image inspect dcjulian29/minecraft:%VERSION%-paper > .docker\minecraft_%VERSION%-paper.json

:FINAL

popd

endlocal
