class GameSerializer < ActiveModel::Serializer
  attributes :id, :name, :score, :created_at, :updated_at, :difficulty, :weapon, :backup_supply, :accuracy, :rejected

  has_many :users
  has_many :chatrooms
  has_many :user_games
end
