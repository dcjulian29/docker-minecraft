@docker run --rm -d -p 8080:80 --name minecraft dcjulian29/minecraft
@docker exec -it minecraft bash
@docker stop minecraft
