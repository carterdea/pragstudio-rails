require 'rails_helper'

describe "Navigation" do
  it "allows navigation from the project index page to the project show page" do
    project = Project.create(project_attributes)

    visit projects_url

    click_on project.name

    expect(current_path).to eq(project_path(project))
  end

  it "allows navigation from the project show page back to the project index page" do
    project = Project.create(project_attributes)

    visit project_url(project)

    click_on "All Projects"

    expect(current_path).to eq(root_path)
  end
end
