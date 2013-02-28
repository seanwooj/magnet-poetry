class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password,
                  :password_confirmation,
                  :remember_me, :first_name,
                  :last_name, :username

  attr_accessible :provider, :uid

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

  # OAUTH
  def self.find_for_facebook_oauth(auth, current_user)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    logger.debug "#{auth.info}"

    unless user
      user = User.create!(
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        first_name: auth.info.first_name,
        last_name: auth.info.last_name,
        username: auth.info.nickname,
        password: Devise.friendly_token[0,20]
      )
    end

    user
  end

  def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
end
