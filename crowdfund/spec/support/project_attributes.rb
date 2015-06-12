def project_attributes(override = {})
  {
    name: "AdoptTogether",
    description: "Kickstarter for Adoptions",
    target_pledge_amount: 4000000.00,
    pledging_ends_on: 5.days.from_now,
    website: "http://www.adopttogether.org",
    team_members: "Hank Fortener",
    image_file_name: "adoptogether.jpg"
  }.merge(override)
end

def pledge_attributes(override = {})
  {
    name: "John Doe",
    email: "johndoe@example.com",
    comment: "Keep up the great work!",
    amount: 100,
  }.merge(override)
end