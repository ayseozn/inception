all:
	@mkdir -p /home/aysozen/data/wordpress
	@mkdir -p /home/aysozen/data/mariadb
	@bash srcs/create_secrets.sh
	@docker-compose -f srcs/docker-compose.yml up --build

start:
	@docker-compose -f srcs/docker-compose.yml start

stop:
	@docker-compose -f srcs/docker-compose.yml stop

clean:
	@docker-compose -f srcs/docker-compose.yml down --volumes

fclean: clean
	@docker system prune -af
	@rm -rf /home/aysozen/data

.PHONY: all start stop clean fclean re