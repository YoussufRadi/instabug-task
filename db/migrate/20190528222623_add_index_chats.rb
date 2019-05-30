class AddIndexChats < ActiveRecord::Migration[5.2]
  def change
    add_index :chats, :chat_number
  end
end
