all:
	@mkdir -p /home/ayse/data/wordpress
	@mkdir -p /home/ayse/data/mariadb
	@docker-compose -f srcs/docker-compose.yml up --build

start:
	@docker-compose -f srcs/docker-compose.yml start

stop:
	@docker-compose -f srcs/docker-compose.yml stop

clean:
	@docker-compose -f srcs/docker-compose.yml down --volumes
	@sudo rm -rf /home/ayse/data

fclean: clean
	@docker system prune -af

.PHONY: all start stop clean fclean re