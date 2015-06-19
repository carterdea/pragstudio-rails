class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  STARS = (1..5).to_a

  validates :comment, length: {minimum: 4}
  validates :stars, inclusion: {in: STARS, message: "Must be between 1 & 5"}
end
