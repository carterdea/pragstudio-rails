require 'rails_helper'

describe "Creating a new project" do

  it "saves the project and shows the new project's details" do
    visit projects_url

    click_link "Add New Project"

    expect(current_path).to eq(new_project_path)

    fill_in "Name", with: "New Project Name"
    fill_in "Description", with: "A brand new project"
    fill_in "Target pledge amount", with: "3000"
    # fill_in "Pledging ends on", with: (Date.today.year + 1).to_s
    fill_in "project[pledging_ends_on]", with: '2015-09-01'
    fill_in "Website", with: "http://example.com"

    click_button "Create Project"

    expect(current_path).to eq(project_path(Project.last))

    expect(page).to have_text("New Project Name")
    expect(page).to have_text("A brand new project")
    expect(page).to have_text("$3,000.00")
    expect(page).to have_text("http://example.com")
  end

end