class Movie < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :critics, through: :reviews, source: :user
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :title, :released_on, :duration, :director, :cast, presence: true
  validates :description, length: {minimum: 25}
  validates :rating, inclusion: {in: RATINGS}
  validates :total_gross, numericality: {greater_than_or_equal_to: 0}
  validates :image_file_name, allow_blank: true, format: {
    with:    /\w+\.(gif|jpg|png)\z/i,
    message: "must reference a GIF, JPG, or PNG image"
  }

  def flop?
    total_gross.blank? || total_gross < 50000000 && !(cult?)
  end

  def self.released
    where("released_on <= ?", Time.now).order("released_on")
  end

  def self.hits
    where("total_gross >= 300000000").order(total_gross: :desc)
  end

  def self.flops
    where("total_gross <= 50000000").order(total_gross: :asc)
  end

  def self.recently_added
    order('created_at desc').limit(3)
  end

  def cult?
    average_stars.to_i >= 4 && reviews.count > 4
  end

  def recent_reviews
    reviews.order('created_at desc').limit(2)
  end

  def average_stars
    reviews.average(:stars)
  end
end
