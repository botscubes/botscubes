# Telegram Bot Constructor  

## Переменные окружения  

### ***bot.env***

Variable | Required
--- | ---
TBOT_WEBHOOK_BASE | Yes
TBOT_LISTEN_ADDRESS | Yes
TBOT_LOG_LEVEL | Optional
TBOT_LOG_FORMAT | Optional
TBOT_LOG_PATH | Optional  

### ***nginx.env***

Variable | Required
--- | ---
NGINX_BOT_LISTEN_PORT | Yes
NGINX_SERVER_NAME | Yes  

### ***pgsql_bot.env***  

Variable | Required
--- | ---
POSTGRES_DB | Yes
POSTGRES_USER | Yes  
POSTGRES_PASSWORD | Yes  
POSTGRES_HOST | Yes  
POSTGRES_PORT | Yes  

## Запуск  

1. Создать и заполнить **.env** файлы:   

- bot.env 
- pgsql_bot.env 
- nginx.env  

Файлы *.env.sample - шаблоны **.env** файлов  

2. Указать домен и email в файле *init-letsencrypt.sh* 

3. Выполнить 

```sh
./init-letsencrypt.sh
make start
```