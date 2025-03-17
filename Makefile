
all: build
	@docker-compose -f ./srcs/docker-compose.yml up -d

build:
	@chmod +x ./srcs/tools/create_volumes.sh
	sh srcs/tools/create_volumes.sh
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re:
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

clean: down
	@docker system prune -a

fclean:
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes


.PHONY : all build down re clean fclean