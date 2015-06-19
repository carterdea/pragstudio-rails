require 'rails_helper'

describe "Viewing the list of users" do

  it "shows the users" do
    user1 = User.create!(user_attributes(name: "Larry", username: "larry1", email: "larry@example.com"))
    user2 = User.create!(user_attributes(name: "Moe", username: "moeguy1", email: "moe@example.com"))
    user3 = User.create!(user_attributes(name: "Curly", username: "curlyfries", email: "curly@example.com"))
    sign_in(user1)
    visit users_url

    expect(page).to have_link(user1.name)
    expect(page).to have_link(user2.name)
    expect(page).to have_link(user3.name)
  end

end