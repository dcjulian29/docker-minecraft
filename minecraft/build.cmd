docker build -t dcjulian29/minecraft:1.16.5 .
docker tag dcjulian29/minecraft:1.16.5 dcjulian29/minecraft:latest
docker build -t dcjulian29/minecraft:1.16.5-vanilla -f Dockerfile-Vanilla .
docker tag dcjulian29/minecraft:1.16.5-vanilla dcjulian29/minecraft:latest-vanilla
docker push dcjulian29/minecraft --all-tags
