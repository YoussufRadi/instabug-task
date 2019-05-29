# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version : 2.6.3

The available API routes are:

- GET /users/ Return user's info, requires a token in "Authorization" as Headed
- POST /users/ Creates a new user, requires a body with JSON {"name":"string"}
- PATCH /users/:id Modifies user's info, requires a body with JSON {"name":"string"}, requires a token in "Authorization" as Headed
- Delete /users/:id Modifies user's info, requires a token in "Authorization" as Headed
- POST /auth/login/ Return user's token, requires a body with JSON {"name":"string"}

- GET /chats/ Return user's chats, requires a token in "Authorization" as Headed
- GET /chats/:chat_number Return user's specific chat with a number, requires a token in "Authorization" as Headed
- POST /chats/ Creates a new chat with a number, requires a token in "Authorization" as Headed
- DELETE /chats/:chat_number Deletes chat with a number, requires a token in "Authorization" as Headed

- GET /chats/:chat_number/messages/ Return chat's messages, requires a token in "Authorization" as Headed
- GET /chats/:chat_number/messages/:message_number Return user's specific message with a number, requires a token in "Authorization" as Headed
- POST /chats/:chat_number/messages/ Creates a new chat' message with a number, requires a body with JSON {"body":"string"}, requires a token in "Authorization" as Headed
- DELETE /chats/:chat_number/messages/:message_number Deletes a message with a number, requires a token in "Authorization" as Headed
- PATCH /chats/:chat_number/messages/:message_number Modifies a message with a number, requires a body with JSON {"body":"string"}, requires a token in "Authorization" as Headed
