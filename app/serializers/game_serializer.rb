class GameSerializer < ActiveModel::Serializer
  attributes :id, :name, :score, :created_at, :updated_at, :difficulty, :weapon, :backup_supply

  has_many :users
  has_many :chatrooms
end
