class AddIndexMessages < ActiveRecord::Migration[5.2]
  def change
    add_index :messages, :message_number
  end
end
