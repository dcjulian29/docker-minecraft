docker build -t dcjulian29/minecraft:1.16.4 .
docker tag dcjulian29/minecraft:1.16.4 dcjulian29/minecraft:latest
docker push dcjulian29/minecraft --all-tags
