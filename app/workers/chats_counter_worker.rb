# frozen_string_literal: true

class ChatsCounterWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform(current_user_id, chats_count)

    @user = User.find(current_user_id)
    if @user.update(chats_count: chats_count)
        puts @user.chats_count
        puts "Saved"
    else
        puts "Error"
        print @user.errors.full_messages
        raise 'An error has occured' +  @user.errors.full_messages 
    end
  end
end