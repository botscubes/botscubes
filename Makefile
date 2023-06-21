start:
	docker compose up -d

stop:
	docker compose stop

restart:
	docker compose restart

down:
	docker compose down --remove-orphans

ps:
	docker compose ps

recreate: stop
	docker compose up -d

bot-run:
	docker compose exec bot go run ./cmd/bot/main.go

bot-bash:
	docker compose exec -it bot bash

bot-tidy:
	docker compose exec bot go mod tidy

bot-restart:
	docker compose restart bot

bot-logs:
	docker compose logs --tail 200 bot -f

dart: bot-restart bot-logs

user-tidy:
	docker compose exec user go mod tidy

user-bash:
	docker compose exec -it user bash

user-run:
	docker compose exec user go run ./cmd/server.go

user-restart:
	docker compose restart user

web-sh:
	docker compose exec -it web sh

web-rebuild:
	docker compose up -d --build web

hp-logs:
	docker compose logs --tail 200 haproxy -f

hp-sh:
	docker compose exec -it haproxy sh

hp-restart:
	docker compose restart haproxy

hp-reload:
	docker compose kill -s HUP haproxy