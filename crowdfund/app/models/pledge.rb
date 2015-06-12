class Pledge < ActiveRecord::Base
  belongs_to :project

  AMOUNT_LEVELS = [25, 50, 100, 200, 500]

  validates :name, presence: true
  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :amount, inclusion: { in: AMOUNT_LEVELS, message: "Must be $25, $50, $100, $200, or $500."}
end
