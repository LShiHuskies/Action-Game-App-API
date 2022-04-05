class UserGameSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :game_id, :accepted, :health, :top, :left, :direction

  belongs_to :user
  belongs_to :game
end
