# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: antauber <antauber@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/26 15:47:48 by bert              #+#    #+#              #
#    Updated: 2025/06/27 17:36:43 by antauber         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


## ########################################################################## ##
#   INGREDIENTS																  ##
## ########################################################################## ##

NAME			= inception
LOGIN			= $(shell whoami)
COMPOSE_FILE	= srcs/docker-compose.yml
DOCK			= docker compose -f $(COMPOSE_FILE)


## ########################################################################## ##
#   RECIPES																	  ##
## ########################################################################## ##

## Launch conatainers without rebuild
up:
	@mkdir -p /home/$(LOGIN)/data/mariadb /home/$(LOGIN)/data/wordpress /home/$(LOGIN)/data/nginx
	$(DOCK) up -d

## Build Dockers images without launch containers
build:
	$(DOCK) build

## Stop containers
down:
	$(DOCK) down

## Stop and delete volumes and orphans containers
clean: down
	$(DOCK) down -v --remove-orphans
	@rm -rf /home/$(LOGIN)/data/mariadb
	@rm -rf /home/$(LOGIN)/data/wordpress
	@rm -rf /home/$(LOGIN)/data/nginx

## Full clean and delete all images and volumes. No dockers remaining on system
fclean: clean
	docker system prune -af --volumes
	$(MAKE) status

## Complete rebuild
re: clean 
	$(MAKE) build
	$(MAKE) up


## ########################################################################## ##
#   DEBUG RECIPES															  ##
## ########################################################################## ##

status:
	@$(DOCK) ps
	docker volume ls
	docker images ls

logs:
	$(DOCK) logs -f

logs-mariadb:
	$(DOCK) logs -f mariadb

logs-nginx:
	$(DOCK) logs -f nginx

logs-wordpress:
	$(DOCK) logs -f wordpress

## ! ajouter des tests de connectivité



.PHONY: build up down log status clean re