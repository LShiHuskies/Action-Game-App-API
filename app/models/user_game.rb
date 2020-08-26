class UserGame < ApplicationRecord

 belongs_to :user
 belongs_to :game

 has_one :chatroom
 has_many :messages, :chatroom

end
