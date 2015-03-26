class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  validates :email, presence: true, uniqueness: true
  enum provider: %w(todolist facebook)

  def self.find_for_facebook_oauth(auth)
    if user = User.find_by(email: auth.info.email)
      user
    else
      User.create(email: auth.info.email, provider: auth.provider, password: Devise.friendly_token[0,20])
    end
  end

end
