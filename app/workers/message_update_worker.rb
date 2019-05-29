# frozen_string_literal: true

class MessageUpdateWorker
  include Sidekiq::Worker
  sidekiq_options queue: :message_create

  def perform(id, body)
    @message = Message.find(id)
    if @message.update(body: body)
        puts "Saved"
    else
        puts "Error"
        print @message.errors.full_messages
        raise 'An error has occured' +  @message.errors.full_messages 
    end
  end
end