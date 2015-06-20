class Movie < ActiveRecord::Base
  has_many :reviews, -> { order(created_at: :desc)}, dependent: :destroy
  has_many :critics, through: :reviews, source: :user
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  scope :upcoming, -> { where("released_on > ?", Time.now).order(released_on: :asc) }
  scope :released, -> { where("released_on <= ?", Time.now).order(released_on: :asc) }
  scope :hits, -> { released.where("total_gross >= 300000000").order(total_gross: :desc) }
  scope :flops, -> { released.where("total_gross <= 50000000").order(total_gross: :asc) }
  scope :rated, -> (rating){ released.where(rating: rating) }
  scope :recent, -> (max=5){ released.limit(max) }
  scope :grossed_less_than, -> (gross=25000000) { released.where("total_gross < ?", gross) }
  scope :grossed_greater_than, -> (gross=500000000) { released.where("total_gross > ?", gross) }

  RATINGS = %w(G PG PG-13 R NC-17)

  before_validation :generate_slug

  validates :released_on, :duration, :director, :cast, presence: true
  validates :title, presence: true, uniqueness: true
  validates :description, length: {minimum: 25}
  validates :rating, inclusion: {in: RATINGS}
  validates :total_gross, numericality: {greater_than_or_equal_to: 0}
  validates :image_file_name, allow_blank: true, format: {
    with:    /\w+\.(gif|jpg|png)\z/i,
    message: "must reference a GIF, JPG, or PNG image"
  }
  validates :slug, presence: true, uniqueness: true

  def flop?
    total_gross.blank? || total_gross < 50000000 && !(cult?)
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

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= title.parameterize if title
  end
end
