require 'rails_helper'

describe 'Viewing an individual project' do
  it "shows the project's details" do
    project = Project.create(project_attributes)

    visit project_url(project)

    expect(page).to have_text(project.name)
    expect(page).to have_text(project.description)
    expect(page).to have_text("$4,000,000.00")
    expect(page).to have_text("5 days remaining")
    expect(page).to have_link('Visit', href: project.website)
    expect(page).to have_text(project.team_members)
    expect(page).to have_selector("img[src$='#{project.image_file_name}']")
  end

  it "shows the number of days remaining if the end date is in the future" do
    project = Project.create(project_attributes(pledging_ends_on: 2.days.from_now))

    visit project_url(project)

    expect(page).to have_text("2 days remaining")
  end

  it "shows 'All done!' if the pledging end date is in the past" do
    project = Project.create(project_attributes(pledging_ends_on: 2.days.ago))

    visit project_url(project)

    expect(page).to have_text("All done!")
  end

  it "shows the amount outstanding with a pledge link if the project is not funded" do
    project = Project.create(project_attributes(target_pledge_amount: 100.00))
    project.pledges.create(pledge_attributes(amount: 50.00))

    visit project_url(project)

    expect(page).to_not have_text("Only $100.00 left!")
    expect(page).to have_link("Make a Pledge")
    expect(page).to_not have_text("Funded!")
  end

  it "shows 'Funded' without a pledge link if the project is funded" do
    project = Project.create(project_attributes(target_pledge_amount: 100.00))
    project.pledges.create(pledge_attributes(amount: 50.00))
    project.pledges.create(pledge_attributes(amount: 50.00))

    visit project_url(project)

    expect(page).to have_text("Funded!")

    expect(page).to_not have_link("Make a Pledge", new_project_pledge_path(project))
  end
end