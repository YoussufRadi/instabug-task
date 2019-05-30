# Instabug-task

This is a task done according to specifications sent by instabug using Ruby on Rails V5, Redis, Sidekiq, MySQL and ElasticSearch.

- Ruby version : 2.6.3

## To Run the application follow these steps

- First make sure you have Docker installed
- Second clone the project any where to your pc

```bash
git clone https://github.com/YoussufRadi/instabug-task.git
```

- Then cd to the directory

```bash
cd instabug-task
```

- Run docker to build the compose file

```bash
docker-compose build
```

- Use docker to create the database

```bash
docker-compose run www rake db:create
```

- Run docker again to migrate the database

```bash
docker-compose run www rake db:migrate
```

- Finally start the compose file

```bash
docker-compose up
```

This should run the whole orchestrated technologies to launch an API end point on localhost:3000

## The available API routes are:

- GET /users/ Return user's info, requires a token in "Authorization" as Headed
- POST /users/ Creates a new user, requires a body with JSON {"name":"string"}
- PATCH /users/:id Modifies user's info, requires a body with JSON {"name":"string"}, requires a token in "Authorization" as Headed
- Delete /users/:id Modifies user's info, requires a token in "Authorization" as Headed
- POST /auth/login/ Return user's token, requires a body with JSON {"name":"string"}

- GET /chats/ Return user's chats, requires a token in "Authorization" as Headed
- GET /chats/:chat_number Return user's specific chat with a number, requires a token in "Authorization" as Headed
- POST /chats/ Creates a new chat with a number, requires a token in "Authorization" as Headed
- DELETE /chats/:chat_number Deletes chat with a number, requires a token in "Authorization" as Headed

- GET /chats/:chat_id/messages/search?body="SEARCH PARAM" Search through chat's messages and returns the one that matches the SEARCH PARAM
- GET /chats/:chat_number/messages/ Return chat's messages, requires a token in "Authorization" as Headed
- GET /chats/:chat_number/messages/:message_number Return user's specific message with a number, requires a token in "Authorization" as Headed
- POST /chats/:chat_number/messages/ Creates a new chat' message with a number, requires a body with JSON {"body":"string"}, requires a token in "Authorization" as Headed
- DELETE /chats/:chat_number/messages/:message_number Deletes a message with a number, requires a token in "Authorization" as Headed
- PATCH /chats/:chat_number/messages/:message_number Modifies a message with a number, requires a body with JSON {"body":"string"}, requires a token in "Authorization" as Headed
