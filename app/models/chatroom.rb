class Chatroom < ApplicationRecord

  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  belongs_to :user_game

end
