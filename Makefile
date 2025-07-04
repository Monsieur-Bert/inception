# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bert <bert@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/26 15:47:48 by bert              #+#    #+#              #
#    Updated: 2025/07/04 17:20:17 by bert             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


## ########################################################################## ##
#   INGREDIENTS																  ##
## ########################################################################## ##

NAME			= inception
LOGIN			= $(shell whoami)
COMPOSE_FILE	= srcs/docker-compose.yml
DOCK			= docker compose -f $(COMPOSE_FILE)


# ########################################################################### ##
#	ANSI_CODES																  ##
## ########################################################################## ##

GREEN		:=	\033[1;32m
BLUE		:=	\033[1;34m
RED			:=	\033[1;31m
YELLOW		:=	\033[1;33m
RESET		:=	\033[0m


## ########################################################################## ##
#   RECIPES																	  ##
## ########################################################################## ##

all: build up

## Launch conatainers without rebuild
up:
	@mkdir -p /home/$(LOGIN)/data/mariadb /home/$(LOGIN)/data/wordpress
	$(DOCK) up -d

## Build Dockers images without launch containers
build:
	- docker rmi srcs-mariadb srcs-nginx srcs-wordpress srcs-redis
	$(DOCK) build

## Stop containers
down:
	$(DOCK) down

## Stop and delete volumes and orphans containers
clean: down
	$(DOCK) down -v --remove-orphans
	sudo rm -rf /home/$(LOGIN)/data/mariadb/*
	sudo rm -rf /home/$(LOGIN)/data/wordpress/*

## Full clean and delete all images and volumes. No dockers remaining on system
fclean: clean
	docker system prune -af --volumes

## Clear only the cache build
prune-cache:
	docker builder prune -f

## Complete rebuild
re: clean 
	$(MAKE) --no-print-directory build
	$(MAKE) --no-print-directory up


## ########################################################################## ##
#   DEBUG RECIPES															  ##
## ########################################################################## ##

status:
	@printf "$(YELLOW)--> Containers Status (docker ps)$(RESET)\n"
	@$(DOCK) ps
	@printf "$(YELLOW)--> Containers IPs$(RESET)\n"
	@docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} - {{.Name}}' $$(docker ps -q)
	@printf "$(YELLOW)--> Volumes Status (docker volume)$(RESET)\n"
	@docker volume ls
	@printf "$(YELLOW)--> Images Status (docker image)$(RESET)\n"
	@docker image ls
	@docker system df

logs:
	$(DOCK) logs -f

logs-mariadb:
	$(DOCK) logs -f mariadb

logs-nginx:
	$(DOCK) logs -f nginx

logs-wordpress:
	$(DOCK) logs -f wordpress

logs-redis:
	$(DOCK) logs -f redis

connectivity:
	@printf "$(YELLOW)--> Ping Wordpress → MariaDB $(RESET)\n"
	@docker exec wordpress ping -c 3 mariadb || echo "$(RED)Wordpress can't reach MariaDB$(RESET)\n"
	@printf "$(YELLOW)--> Ping Wordpress → NGINX $(RESET)\n"
	@docker exec wordpress ping -c 3 nginx || echo "$(RED)Wordpress can't reach NGINX$(RESET)\n"

.PHONY: build up down clean fclean re prune-cache \
		status connectivity \
		logs logs-mariadb logs-nginx logs-wordpress logs-redis
