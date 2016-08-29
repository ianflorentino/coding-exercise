class User < ApplicationRecord
  has_many :user_tasks
  has_many :tasks, through: :user_tasks

  def generate_auth_token
    self.prynt_auth_token = SecureRandom.hex
  end

  def self.find_or_create_from_oauth(auth)
    where(uid: auth.uid).first_or_create(
      uid: auth.uid, 
      provider: auth.provider, 
      name: auth.info.name, 
      oauth_token: auth.credentials.token, 
      oauth_token_expires_at:  Time.at(auth.credentials.expires_at))
  end
end
