LOCAL_RUN = false

DOCKER_CONFIG = docker-compose.yml

ifeq ($(LOCAL_RUN), true)
	DOCKER_CONFIG = docker-compose.local.yml
endif


# start & reload env
start:
	docker compose -f $(DOCKER_CONFIG) up -d

stop:
	docker compose -f $(DOCKER_CONFIG) stop

restart:
	docker compose -f $(DOCKER_CONFIG) restart

down:
	docker compose -f $(DOCKER_CONFIG) down --remove-orphans

ps:
	docker compose -f $(DOCKER_CONFIG) ps

recreate: stop
	docker compose -f $(DOCKER_CONFIG) up -d

bot-run:
	docker compose -f $(DOCKER_CONFIG) exec bot go run ./cmd/bot/main.go

bot-bash:
	docker compose -f $(DOCKER_CONFIG) exec -it bot bash

bot-tidy:
	docker compose -f $(DOCKER_CONFIG) exec bot go mod tidy

bot-restart:
	docker compose -f $(DOCKER_CONFIG) restart bot

bot-logs:
	docker compose -f $(DOCKER_CONFIG) logs --tail 200 bot -f

dart: bot-restart bot-logs

user-tidy:
	docker compose -f $(DOCKER_CONFIG) exec user go mod tidy

user-bash:
	docker compose -f $(DOCKER_CONFIG) exec -it user bash

user-run:
	docker compose -f $(DOCKER_CONFIG) exec user go run ./cmd/server.go

user-restart:
	docker compose -f $(DOCKER_CONFIG) restart user

web-sh:
	docker compose -f $(DOCKER_CONFIG) exec -it web sh

web-rebuild:
	docker compose -f $(DOCKER_CONFIG) up -d --build web

hp-logs:
	docker compose -f $(DOCKER_CONFIG) logs --tail 200 haproxy -f

hp-sh:
	docker compose -f $(DOCKER_CONFIG) exec -it haproxy sh

hp-restart:
	docker compose -f $(DOCKER_CONFIG) restart haproxy

hp-reload:
	docker compose -f $(DOCKER_CONFIG) kill -s HUP haproxy

worker-tidy:
	docker compose -f $(DOCKER_CONFIG) exec bot-worker go mod tidy

worker-logs:
	docker compose -f $(DOCKER_CONFIG) logs --tail 200 bot-worker -f

worker-restart:
	docker compose -f $(DOCKER_CONFIG) restart bot-worker

wart: worker-restart worker-logs

worker-bash:
	docker compose -f $(DOCKER_CONFIG) exec -it bot-worker bash