class Game < ApplicationRecord
  before_save { self.name = name.downcase }

  has_many :user_games
  has_many :users, through: :user_games
  has_many :chatrooms, through: :user_games
  has_many :messages, through: :chatrooms

  validates :name, uniqueness: true, length: { minimum: 5, maximum: 30 }

end
