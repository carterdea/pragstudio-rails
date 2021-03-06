class Project < ActiveRecord::Base
  has_many :pledges, dependent: :destroy
  
  validates :name, :team_members, :pledging_ends_on, presence: true
  validates :description, length: {minimum: 25, maximum: 500}
  validates :target_pledge_amount, numericality: {greater_than: 0}
  validates :website, format: { with: URI.regexp, message: "Must be a valid URL"}
  validates :image_file_name, allow_blank: true, format: {
    with:    /\w+\.(gif|jpg|png)\z/i,
    message: "Must reference a GIF, JPG, or PNG image"
  }

  def pledging_expired?
    pledging_ends_on.past?
  end

  def total_pledges
    pledges.sum(:amount)
  end

  def amount_outstanding
    target_pledge_amount - total_pledges
  end

  def funded?
    target_pledge_amount <= total_pledges
  end

  def self.accepting_pledges
    where("pledging_ends_on >= ?", Time.now).order(pledging_ends_on: :desc)
  end
end
