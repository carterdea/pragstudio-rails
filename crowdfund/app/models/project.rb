class Project < ActiveRecord::Base
  def pledging_expired?
    pledging_ends_on.past?
  end

  def self.accepting_pledges
    where("pledging_ends_on >= ?", Time.now).order(pledging_ends_on: :desc)
  end
end
