class UserGame < ApplicationRecord

 belongs_to :user
 belongs_to :game

 has_many :chatrooms
 has_many :messages, through: :chatrooms

end
