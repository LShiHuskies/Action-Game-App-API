class Chatroom < ApplicationRecord

  has_many :messages
  has_many :users, through: :messages
  belongs_to :user_game
  
end
