class CountersWorker
  include Sidekiq::Worker

  def perform(*args)
    User.all.each do |user|
        chats = user.chats
        if user.update(chats_count: chats.count)
            puts "Username: " + user.name + " Chat Counter Updated"
        else
            puts "Username: " + user.name + " Faced error updating"
        end
        chats.each do |chat|
            messages = chat.messages
            if chat.update(messages_count: messages.count)
                puts "Chat id: " + chat.id.to_s + " Counter Updated"
            else
                puts "Chat id: " + chat.id.to_s + " Faced error updating"
            end        
        end
    end
  end
end
