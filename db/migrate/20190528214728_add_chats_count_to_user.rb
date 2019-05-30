class AddChatsCountToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :chats_count, :integer, :default => 0
  end
end
