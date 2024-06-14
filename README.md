# Telegram Bot Constructor  

## Переменные окружения  

<details>
    <summary>Списки переменных окружения</summary>

***bot.env***

Variable | Required
--- | ---
WEBHOOK_DOMAIN | Yes
WEBHOOK_PATH | Yes
LISTEN_ADDRESS | Yes
JWT_SECRET_KEY | Yes
LOGGER_TYPE | Optional
NATS_URL | Yes

`LOGGER_TYPE` - возможные значения:  
- `dev`
- `prod`

***bot_worker.env***

Variable | Required
--- | ---
WEBHOOK_PATH | Yes
LISTEN_ADDRESS | Yes
NATS_URL | Yes
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

## Установка

Создайте папку с приложением и перейдите в неё:

```sh
mkdir app && cd app
```

Склонируйте данный репозиторий:
```sh
git clone https://github.com/botscubes/botscubes.git
```

Перейдите в папку с конфигурацией конструктора
```sh
cd botscubes
```

Запустите установку:
```sh
./install.sh
```

## Конфигурация

Конфигурация: 

- Скопировать в папку `/config/env/` все файлы из `/config/env/samples`

- Заполнить файлы необходимыми данными

- Измените [конфигурацию на веб-клиенте](https://github.com/botscubes/web-client#конфигурация):

```sh
mv ../web-client/src/config.example.ts ../web-client/src/config.ts
```

## Запуск на сервере  

Выполните:

```sh
./init-letsencrypt.sh
make start
```


## Запуск локально (Ngrok)  

1. Настройка Ngrok

В [личном кабинете Ngrok][ngrok_dashboard] получить:

- [Cтатический домен][ngrok_get_static_domain]

- [Токен авторизации][ngrok_get_authtoken]

Удалить _.sample_ из названия файла `/config/ngrok.yml.sample` чтобы получилось `/config/ngrok.yml`  
В данном файле указать полученные в панели управления Ngrok токен и домен

В файле Makefile установить значение `LOCAL_RUN = true`


2. Выполнить 

```sh
make start
```

[//]: # (LINKS)
[ngrok_dashboard]: https://dashboard.ngrok.com/
[ngrok_get_static_domain]: https://dashboard.ngrok.com/cloud-edge/domains
[ngrok_get_authtoken]: https://dashboard.ngrok.com/tunnels/authtokens
