@echo off
setlocal

pushd %~dp0

IF exist .docker ( echo .docker exists ) ELSE ( mkdir .docker && echo .docker created)

for /f "delims=" %%x in (VERSION_BEDROCK) do set BEDROCK=%%x

echo.
echo *
echo * Bedrock Build (%BEDROCK%)
echo *
echo.

docker build --build-arg VERSION=%BEDROCK% -t dcjulian29/bedrock:%BEDROCK% bedrock\.

if %errorlevel% neq 0 goto FINAL

docker tag dcjulian29/bedrock:%BEDROCK% dcjulian29/bedrock:latest
docker image inspect dcjulian29/bedrock:%BEDROCK% > .docker\bedrock_%BEDROCK%.json

:FINAL

popd

endlocal
