# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dcyprien <dcyprien@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/28 10:56:09 by minh-ngu          #+#    #+#              #
#    Updated: 2025/06/26 15:50:39 by ngoc             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FOLDER := "."
DOCKERFILE := "./docker-compose.yml"

all:
	@cd $(FOLDER) && \
	docker compose -f $(DOCKERFILE) up -d --build
	@cd $(FOLDER) && \
	docker compose -f $(DOCKERFILE) logs -f

down:
	@cd $(FOLDER) && \
	docker compose -f $(DOCKERFILE) down

up:
	@cd $(FOLDER) && \
	docker compose -f $(DOCKERFILE) up -d --build
	@cd $(FOLDER) && \
	docker compose -f $(DOCKERFILE) logs -f

stop:
	@docker stop $$(docker ps)

remove_con:
	@docker rm -f $$(docker ps -a -q)

remove_images:
	@docker image prune --all --force

re:
	@make down
	@make up

clean:
	-docker stop $$(docker ps -qa)
	-docker rm $$(docker ps -qa)
	-docker rmi -f $$(docker images -qa)
	-docker volume rm $$(docker volume ls -q)
	-docker network rm $$(docker network ls -q)
	-docker builder prune --all
	-docker system prune --all --volumes
	-docker network prune

cleandata:
	-rm -rf odoo_db/*
	-rm -rf pg_db/*
	-rm -rf odoo_backup/*
	-rm -rf pg_backup/*

tmp:
	#./docker-compose.ymldocker exec -it node sh
	# docker exec -it cmp-services-backend-api-1 /bin/sh
	# docker exec -it postgres /bin/sh
	# docker exec -it cmp_service_elasticsearch /bin/bash
	# docker exec -it cmp_service_kibana /bin/bash
	docker exec -it odoo /bin/bash
	# docker cp ./postgres/backup.sh postgres:/app/backup.sh

config:
	# Show config files
	psql -U postgres -c "SHOW config_file;"
	/usr/bin/pg_dump --no-owner --file=/tmp/tmpjva6rye7/dump.sql comacpro_odoo

build:
	cd odoo && sudo docker build -t test-odoo .
	
run:
	docker run --rm -ti \
		--name con-odoo \
		-p 8069:8069 \
		test-odoo sh

owner:
	sudo chown -R $(USER):$(USER) ./odoo_addons

gitd:
	git add -A -- :!*.o :!*.swp :!*.env :!*.crt :!*.key
	git commit -m "$(M)"
	git push
	
.PHONY: all clean fclean re test tmp build run
