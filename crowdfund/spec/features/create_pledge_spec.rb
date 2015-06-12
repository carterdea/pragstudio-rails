require 'rails_helper'

describe "Creating a new pledge" do
  it "saves the pledge if it's valid" do
    project = Project.create(project_attributes)

    visit project_url(project)

    click_link "Make a Pledge"

    expect(current_path).to eq(new_project_pledge_path(project))

    fill_in "Name", with: "Carter De Angelis"
    fill_in "Email", with: "carterdea@gmail.com"
    select 100, :from => "pledge_amount"
    fill_in "Comment", with: "Great job guys! I love what you're doing"
    click_button("Make a Pledge")

    expect(current_path).to eq(project_pledges_path(project))
    expect(page).to have_text("Thanks for your generous contribution! It means a lot.")
  end

  it "doesn't save the pledge if it's invalid" do
    project = Project.create(project_attributes)

    visit new_project_pledge_path(project)

    expect {
      click_button 'Make a Pledge'
    }.not_to change(Pledge, :count)
    expect(page).to have_text("error")
  end
end