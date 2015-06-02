require 'rails_helper'

describe "Creating a new project" do

  it "saves the project and shows the new project's details" do
    visit projects_url

    click_link "Add a Project"

    expect(current_path).to eq(new_project_path)

    fill_in "Name", with: "New Project Name"
    fill_in "Description", with: "A brand new project that's pretty freaking dope. You guys should come check it out because it's gonna go OFFF!!!"
    # fill_in "Pledging ends on", with: (Date.today.year + 1).to_s
    fill_in "Website", with: "http://example.com"
    fill_in "Team members", with: "The team members"
    fill_in "Image file name", with: "project.png"
    fill_in "Target pledge amount", with: "3000"
    fill_in "project[pledging_ends_on]", with: '2015-09-01'

    click_button "Create Project"

    expect(current_path).to eq(project_path(Project.last))

    expect(page).to have_text("New Project Name")
    expect(page).to have_text("A brand new project")
    expect(page).to have_text("$3,000.00")
    expect(page).to have_text("http://example.com")
    expect(page).to have_text("The team members")

    expect(page).to have_text("Successfully created the project.")
  end

  it "does not save the project if it's invalid" do
    visit new_project_url

    expect {
        click_button 'Create Project'
    }.not_to change(Project, :count)

    expect(page).to have_text('error')
  end
end