class Review < ActiveRecord::Base

  STARS = (1..5).to_a

  validates :name, presence: true
  validates :comment, length: {minimum: 4}
  validates :stars, inclusion: {in: STARS, message: "Must be between 1 & 5"}

  belongs_to :movie
end
