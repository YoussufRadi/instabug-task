# frozen_string_literal: true

class MessagesCounterWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform(chat_id, messages_count)

    @chat = Chat.find(chat_id)
    if @chat.update(messages_count: messages_count)
        puts @chat.messages_count
        puts "Saved"
    else
        puts "Error"
        print @chat.errors.full_messages
        raise 'An error has occured' +  @chat.errors.full_messages 
    end
  end
end