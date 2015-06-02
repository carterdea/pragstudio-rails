require 'rails_helper'

describe "Viewing the list of projects" do
  it "shows the three project names" do
    project1 = Project.create(project_attributes(name: "AdoptTogether",
              description: "Kickstarter for Adoptions",
              target_pledge_amount: 4000000.00,
              pledging_ends_on: 1.day.from_now,
              website: "http://www.adopttogether.org",
              team_members: "Hank Fortener, Erika Saeger",
              image_file_name: "adopttogether.jpg"))
    project2 = Project.create(project_attributes(name: "InterBLOK",
               description: "Repurposing shipping containers to rebuild orphanages & lives",
               target_pledge_amount: 1000.00,
               pledging_ends_on: 15.days.from_now,
               website: "http://www.interblok.org"))
    project3 = Project.create(project_attributes(name: "Red Cross",
               description: "Providing compassionate care to those in need",
               target_pledge_amount: 10000000.00,
               pledging_ends_on: 7.months.from_now,
               website: "http://www.redcross.org"))
    visit projects_url

    expect(page).to have_text("3 Projects")
    expect(page).to have_text(project2.name)
    expect(page).to have_text(project3.name)

    expect(page).to have_text(project1.description)
    expect(page).to have_text("7 months remaining")
    expect(page).to have_text(project1.website)
    expect(page).to have_text("$4,000,000.00")
    expect(page).to have_selector("img[src$='#{project1.image_file_name}']")
  end

  it "does not show a project that is no longer accepting pledges" do
    project = Project.create(project_attributes(pledging_ends_on: 2.days.ago))

    visit projects_url

    expect(page).to_not have_text(project.name)
  end
end
