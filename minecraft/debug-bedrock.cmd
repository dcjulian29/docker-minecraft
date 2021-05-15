@docker run --rm -d -p 19132:19132 -p 19133:19133 -v "/c/code/network/docker/minecraft/server.properties:/minecraft/server.properties:ro" --name minecraft dcjulian29/minecraft:latest-bedrock
@docker exec -it minecraft bash
@docker stop minecraft
