class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_one_attached :avatar, dependent: :destroy
  has_many :user_games
  has_many :games, through: :user_games
  has_many :chatrooms
  has_many :messages, through: :chatrooms

  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true
  validates :email, presence: true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

end
