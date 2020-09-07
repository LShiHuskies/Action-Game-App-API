class Message < ApplicationRecord

  belongs_to :chatroom
  belongs_to :user

  validates :message, presence: true, length: { maximum: 300 }

end
