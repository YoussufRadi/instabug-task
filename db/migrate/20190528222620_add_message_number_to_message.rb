class AddMessageNumberToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :message_number, :integer
  end
end
