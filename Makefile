start:
	docker compose up -d

stop:
	docker compose stop

restart:
	docker compose restart

restart-dev:
	docker compose -f docker-compose.dev.yml restart

ps:
	docker compose -f docker-compose.dev.yml ps

dev: stop-dev
	docker compose -f docker-compose.dev.yml up -d

stop-dev:
	docker compose -f docker-compose.dev.yml stop

# recreate any containers that have changes and leave all unchanged services untouched
recreate:
	docker compose -f docker-compose.dev.yml up -d

bot-run:
	docker compose -f docker-compose.dev.yml exec bot go run ./cmd/bot/main.go

bot-bash:
	docker compose -f docker-compose.dev.yml exec -it bot bash

bot-tidy:
	docker compose -f docker-compose.dev.yml exec bot go mod tidy

bot-restart:
	docker compose -f docker-compose.dev.yml restart bot

bot-logs:
	docker compose -f docker-compose.dev.yml logs --tail 200 bot -f

dart: bot-restart bot-logs

nginx-sh:
	docker compose -f docker-compose.dev.yml exec -it nginx sh

nginx-reload:
	docker compose -f docker-compose.dev.yml exec nginx nginx -s reload

nginx-restart:
	docker compose -f docker-compose.dev.yml restart nginx

down:
	docker compose -f docker-compose.dev.yml down --remove-orphans

user-tidy:
	docker compose -f docker-compose.dev.yml exec user go mod tidy

user-bash:
	docker compose -f docker-compose.dev.yml exec -it user bash

user-run:
	docker compose -f docker-compose.dev.yml exec user go run ./cmd/server.go