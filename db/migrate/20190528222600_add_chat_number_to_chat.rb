class AddChatNumberToChat < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :chat_number, :integer
  end
end
