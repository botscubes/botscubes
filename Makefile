start:
	docker compose up -d

stop:
	docker compose stop

restart:
	docker compose restart

restart-dev:
	docker compose restart

ps:
	docker compose ps

dev: stop-dev
	docker compose -f docker-compose.dev.yml up -d

stop-dev:
	docker compose -f docker-compose.dev.yml stop

# recreate any containers that have changes and leave all unchanged services untouched
recreate:
	docker compose -f docker-compose.dev.yml up -d

bot-run:
	docker compose exec bot go run ./cmd/bot/main.go

bot-bash:
	docker compose exec -it bot bash

bot-tidy:
	docker compose exec bot go mod tidy

nginx-sh:
	docker compose exec -it nginx sh

nginx-reload:
	docker compose exec nginx nginx -s reload

down:
	docker compose -f docker-compose.dev.yml down

user-tidy:
	docker compose exec user go mod tidy

user-bash:
	docker compose exec -it user bash

user-run:
	docker compose exec user go run ./cmd/server.go