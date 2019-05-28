class Chat < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :delete_all

  def as_json(options={})
    super(include: :messages )
  end
end
