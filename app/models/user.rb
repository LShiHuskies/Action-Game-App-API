class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_one_attached :avatar, dependent: :destroy
  has_many :user_games
  has_many :games, through: :user_games
  has_many :chatrooms, through: :user_games
  has_many :messages, dependent: :destroy

  has_secure_password

  attr_accessor :remember_token, :activation_token, :reset_token

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  before_create :create_activation_digest
  before_save :downcase_email

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                              BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    NotifierMailer.account_activation(self).deliver_now
    # NotifierMailer.welcome_email(self).deliver_now
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end
