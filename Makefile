# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bert <bert@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/26 15:47:48 by bert              #+#    #+#              #
#    Updated: 2025/06/26 16:37:53 by bert             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


## ########################################################################## ##
#   INGREDIENTS																  ##
## ########################################################################## ##

NAME			= inception
LOGIN			= $(shell whoami)
COMPOSE_FILE	= srcs/docker-compose.yml
DOCK			= docker-compose -f $(COMPOSE_FILE)


## ########################################################################## ##
#   RECIPES																	  ##
## ########################################################################## ##

all: up

build:
	$(DOCK) build

up: build
	@if [ ! -d /home/$(LOGIN)/data/mariadb ]; then mkdir -p /home/$(LOGIN)/data/mariadb; fi
	@if [ ! -d /home/$(LOGIN)/data/wordpress ]; then mkdir -p /home/$(LOGIN)/data/wordpress; fi
	@if [ ! -d /home/$(LOGIN)/data/nginx ]; then mkdir -p /home/$(LOGIN)/data/nginx; fi
	$(DOCK) up -d

down:
	$(DOCK) down

clean: down
	$(DOCK) down -v --remove-orphans
	@rm -rf /home/$(LOGIN)/data/mariadb
	@rm -rf /home/$(LOGIN)/data/wordpress
	@rm -rf /home/$(LOGIN)/data/nginx

clean-images: clean
	@for img in srcs-mariadb srcs-nginx srcs-wordpress; do \
		docker image ls -q --filter "reference=$$img" | xargs -r docker image rm; \
	done
	docker images

## Complete rebuild
re: clean all


## ########################################################################## ##
#   DEBUG RECIPES															  ##
## ########################################################################## ##

status:
	@$(DOCK) ps

logs:
	$(DOCK) logs -f

logs-mariadb:
	$(DOCK) logs -f mariadb

logs-nginx:
	$(DOCK) logs -f nginx

logs-wordpress:
	$(DOCK) logs -f wordpress

## ! ajouter des tests de connectivité



.PHONY: all build up down log status clean re