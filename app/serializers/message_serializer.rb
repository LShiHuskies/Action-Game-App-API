class MessageSerializer < ActiveModel::Serializer
    attributes :user_id, :chatroom_id, :message, :created_at, :updated_at
    belongs_to :user
    belongs_to :chatroom
  end
  