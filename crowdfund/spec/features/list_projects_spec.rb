require 'rails_helper'

describe "Viewing the list of projects" do
  it "shows the three project names" do
    project1 = Project.create(name: "AdoptTogether",
               description: "Kickstarter for Adoptions",
               target_pledge_amount: 4000000.00,
               pledging_ends_on: 1.day.ago,
               website: "http://www.adopttogether.org")
    project2 = Project.create(name: "InterBLOK",
               description: "Repurposing shipping containers to rebuild orphanages & lives",
               target_pledge_amount: 1000.00,
               pledging_ends_on: 15.days.from_now,
               website: "http://www.interblok.org")
    project3 = Project.create(name: "Red Cross",
               description: "Providing compassionate care to those in need",
               target_pledge_amount: 10000000.00,
               pledging_ends_on: 7.months.from_now,
               website: "http://www.redcross.org")
    visit projects_url

    expect(page).to have_text("3 Projects")
    expect(page).to have_text(project2.name)
    expect(page).to have_text(project3.name)

    expect(page).to have_text(project1.description)
    expect(page).to have_text("7 months remaining")
    expect(page).to have_text(project1.website)
    expect(page).to have_text("$4,000,000.00")
  end
end
