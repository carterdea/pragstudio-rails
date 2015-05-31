require 'rails_helper'

describe 'Viewing an individual project' do
  it "shows the project's details" do
    project = Project.create(project_attributes)

    visit project_url(project)

    expect(page).to have_text(project.name)
    expect(page).to have_text(project.description)
    expect(page).to have_text("$4,000,000.00")
    expect(page).to have_text("5 days remaining")
    expect(page).to have_text(project.website)
  end

  it "shows the number of days remaining if the end date is in the future" do
    project = Project.create(project_attributes(pledging_ends_on: 2.days.from_now))

    visit project_url(project)

    expect(page).to have_text("2 days remaining")
  end

  it "shows 'All done!' if the pledging end date is in the past" do
    project = Project.create(project_attributes(pledging_ends_on: 2.days.ago))

    visit project_url(project)

    expect(page).to have_text("All done")
  end
end