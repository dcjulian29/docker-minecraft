@echo off
setlocal

pushd %~dp0

IF exist .docker ( echo .docker exists ) ELSE ( mkdir .docker && echo .docker created)

for /f "delims=" %%x in (VERSION_BUNGEECORD) do set BUNGEECORD=%%x

echo.
echo *
echo * BungeeCord Build (%BUNGEECORD%)
echo *
echo.

docker build --build-arg VERSION=%BUNGEECORD% -t dcjulian29/bungeecord:%BUNGEECORD% bungeecord\.

if %errorlevel% neq 0 goto FINAL

docker tag dcjulian29/bungeecord:%BUNGEECORD% dcjulian29/bungeecord:latest
docker image inspect dcjulian29/bungeecord:%BUNGEECORD% > .docker\bungeecord_%BUNGEECORD%.json

:FINAL

popd

endlocal
