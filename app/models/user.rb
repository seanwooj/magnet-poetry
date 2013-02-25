class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password,
                  :password_confirmation,
                  :remember_me, :first_name,
                  :last_name, :username

  before_save { |user| user.email = email.downcase }
  before_save { |user| user.username = username.downcase }

  # validates :username, presence: true, length: { maximum: 30 },
  #           uniqueness: { case_sensitive: false }
  # validates :first_name, presence: true, length: { maximum: 30 }
  # validates :last_name, presence: true, length: { maximum: 30 }

  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  #           uniqueness: { case_sensitive: false }

  # validates :password, presence: true, length: { minimum: 6 }
  # validates :password_confirmation, presence: true
end
