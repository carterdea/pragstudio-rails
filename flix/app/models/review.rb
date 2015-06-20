class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  scope :past_n_days, -> (n=7) { where("created_at >= ?", n.days.ago) }

  STARS = (1..5).to_a

  validates :comment, length: {minimum: 4}
  validates :stars, inclusion: {in: STARS, message: "Must be between 1 & 5"}
end
