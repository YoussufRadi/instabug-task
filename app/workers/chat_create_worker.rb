# frozen_string_literal: true

class ChatCreateWorker
  include Sidekiq::Worker
  sidekiq_options queue: :chat_create

  def perform(current_user_id, chat_number)

    @chat = Chat.create(user_id: current_user_id, chat_number: chat_number)
    if @chat.save
        puts "Saved"
    else
        puts "Error"
        print @chat.errors.full_messages
        raise 'An error has occured' +  @chat.errors.full_messages 
    end
  end
end