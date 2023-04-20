dev: stop
	docker compose -f docker-compose.dev.yml up -d
start:
	docker compose up -d

stop:
	docker compose stop

# recreate any containers that have changes and leave all unchanged services untouched
recreate:
	docker compose -f docker-compose.dev.yml up -d

restart:
	docker compose restart

bot-run:
	docker compose exec bot go run ./cmd/bot/main.go

bot-bash:
	docker compose exec -it bot bash

bot-tidy:
	docker compose exec bot go mod tidy

nginx-sh:
	docker compose exec -ti nginx sh

nginx-reload:
	docker compose exec nginx nginx -s reload

ps:
	docker compose ps

down:
	docker compose -f docker-compose.dev.yml down