@echo off
setlocal

pushd %~dp0

IF exist .docker ( echo .docker exists ) ELSE ( mkdir .docker && echo .docker created)

for /f "delims=" %%x in (HASH) do set HASH=%%x
for /f "delims=" %%x in (VERSION) do set VERSION=%%x
for /f "delims=" %%x in (VERSION_PAPER) do set VERSION_PAPER=%%x

echo.
echo *
echo * Vanilla Build (%VERSION%)
echo *
echo.

docker build --no-cache --build-arg HASH=%HASH% -t dcjulian29/minecraft:%VERSION% .

if %errorlevel% neq 0 goto FINAL

docker tag dcjulian29/minecraft:%VERSION% dcjulian29/minecraft:latest
docker image inspect dcjulian29/minecraft:%VERSION% > .docker\minecraft_%VERSION%.json

echo.
echo *
echo * Paper Build (%VERSION%-%VERSION_PAPER%)
echo *
echo.

docker build --no-cache --build-arg VERSION=%VERSION% --build-arg BUILD=%VERSION_PAPER% -t dcjulian29/minecraft:%VERSION%-paper paper/.

if %errorlevel% neq 0 goto FINAL

docker tag dcjulian29/minecraft:%VERSION%-paper dcjulian29/minecraft:latest-paper
docker image inspect dcjulian29/minecraft:%VERSION%-paper > .docker\minecraft_%VERSION%-paper.json

:FINAL

popd

endlocal
