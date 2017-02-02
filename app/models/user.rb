class User < ApplicationRecord
  attr_accessor :remember_token
  before_create :create_remember_token
  has_secure_password

  def User.digest(string)
    Digest::SHA1.hexdigest string.to_s
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(remember_token)
    Digest::SHA1.hexdigest(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def create_remember_token
    self.remember_token = User.new_token
    self.remember_digest = User.digest(remember_token)
  end
end
