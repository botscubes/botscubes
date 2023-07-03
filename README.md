# Telegram Bot Constructor  

## Переменные окружения  

<details>
    <summary>Списки переменных окружения</summary>

***bot.env***

Variable | Required
--- | ---
WEBHOOK_BASE | Yes
LISTEN_ADDRESS | Yes
JWT_SECRET_KEY | Yes
LOGGER_TYPE | Optional

`LOGGER_TYPE` - возможные значения:  
- `dev`
- `prod`

***nginx.env***

Variable | Required
--- | ---
NGINX_BOT_LISTEN_PORT | Yes
NGINX_SERVER_NAME | Yes  
NGINX_USER_LISTEN_PORT | Yes  

***pgsql_bot.env***  
***pgsql_user.env***  

Variable | Required
--- | ---
POSTGRES_DB | Yes
POSTGRES_USER | Yes  
POSTGRES_PASSWORD | Yes  
POSTGRES_HOST | Yes  
POSTGRES_PORT | Yes  

***redis_bot.env***  

Variable | Required
--- | ---
REDIS_DB | Yes
REDIS_PASS | Yes  
REDIS_HOST | Yes  
REDIS_PORT | Yes  

***redis_auth.env***  

Variable | Required
--- | ---
REDIS_AUTH_DB | Yes
REDIS_AUTH_PASS | Yes  
REDIS_AUTH_HOST | Yes  
REDIS_AUTH_PORT | Yes  

</details>


## Запуск  

1. Создать `.env` файлы: 

- Скопировать в папку `/config/env/` все файлы из `/config/env/samples`

- Удалить из названия файлов `.sample`

- Заполнить файлы необходимыми данных

2. Выполнить 

```sh
./init-letsencrypt.sh
make start
```