class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  scope :by_name, -> { order(:name) }
  scope :not_admin, -> { by_name.where(admin: false) }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :name, presence: true
  validates :username, presence: true, format: /\A[A-Z0-9]+\z/i, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: VALID_EMAIL_REGEX, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6, allow_blank: true }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def self.authenticate(email_or_username, password)
    user = User.find_by(email: email_or_username) || User.find_by(username: email_or_username)
    user && user.authenticate(password)
  end  
end
