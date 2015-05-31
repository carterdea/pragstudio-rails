def project_attributes(override = {})
  {
    name: "AdoptTogether",
    description: "Kickstarter for Adoptions",
    target_pledge_amount: 4000000.00,
    pledging_ends_on: 5.days.from_now,
    website: "http://www.adopttogether.org"
  }.merge(override)
end