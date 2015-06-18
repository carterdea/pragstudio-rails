class User < ActiveRecord::Base
  has_secure_password
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, presence: true
  validates :email, presence: true, format: VALID_EMAIL_REGEX, uniqueness: { case_sensitive: false }
end
