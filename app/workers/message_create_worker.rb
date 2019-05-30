# frozen_string_literal: true

class MessageCreateWorker
  include Sidekiq::Worker
  sidekiq_options queue: :message_create

  def perform(chat_id, message_number, body)
    @chat = Message.create(chat_id: chat_id, message_number: message_number, body: body)
    if @chat.save
        puts "Saved"
    else
        puts "Error"
        print @chat.errors.full_messages
        raise 'An error has occured' +  @chat.errors.full_messages 
    end
  end
end