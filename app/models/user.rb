class User < ApplicationRecord
    validates :name, presence: true
    has_many :chats, dependent: :delete_all

  def as_json(options={})
    super(include: { chats: { include:  :messages } })
  end
end
