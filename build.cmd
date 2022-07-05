@echo off
setlocal

pushd %~dp0

for /f "delims=" %%x in (VERSION) do set VERSION=%%x
for /f "delims=" %%x in (VERSION_BEDROCK) do set BEDROCK=%%x
for /f "delims=" %%x in (VERSION_BUNGEECORD) do set BUNGEECORD=%%x

echo.
echo *
echo * Vanilla Build (%VERSION%)
echo *
echo.

docker build --progress plain -t dcjulian29/minecraft:%VERSION% .

if ERRORLEVEL 1 (
  popd
  exit /b %ERRORLEVEL%
)

docker tag dcjulian29/minecraft:%VERSION% dcjulian29/minecraft:latest

pushd paper

echo.
echo *
echo * Paper Build (%VERSION%)
echo *
echo.
docker build --progress plain -t dcjulian29/minecraft:%VERSION%-paper .

if ERRORLEVEL 1 (
  popd
  popd
  exit /b %ERRORLEVEL%
)

docker tag dcjulian29/minecraft:%VERSION%-paper dcjulian29/minecraft:latest-paper

popd
pushd spigot

echo.
echo *
echo * Spigot Build (%VERSION%)
echo *
echo.
docker build --progress plain --build-arg VERSION=1.19 -t dcjulian29/minecraft:%VERSION%-spigot .
if ERRORLEVEL 1 (
  popd
  popd
  exit /b %ERRORLEVEL%
)

docker tag dcjulian29/minecraft:%VERSION%-spigot dcjulian29/minecraft:latest-spigot

popd
pushd bedrock

echo.
echo *
echo * Bedrock Build (%BEDROCK%)
echo *
echo.
docker build --progress plain -t dcjulian29/bedrock:%BEDROCK% .

if ERRORLEVEL 1 (
  popd
  popd
  exit /b %ERRORLEVEL%
)

docker tag dcjulian29/bedrock:%BEDROCK% dcjulian29/bedrock:latest

popd
pushd bungeecord

echo.
echo *
echo * BungeeCord Build (%BUNGEECORD%)
echo *
echo.
docker build --progress plain -t dcjulian29/bungeecord:%BUNGEECORD% .

if ERRORLEVEL 1 (
  popd
  popd
  exit /b %ERRORLEVEL%
)

docker tag dcjulian29/bungeecord:%BUNGEECORD% dcjulian29/bungeecord:latest

popd
popd
endlocal
