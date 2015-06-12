require 'rails_helper'
require 'uri'

describe "a project" do
  it "has expired if the pledging ends on date is in the past" do
    project = Project.new(pledging_ends_on: 2.day.ago)

    expect(project.pledging_expired?).to eq(true)
  end

  it "has not expired if the pledging ends on date is in the future" do
    project = Project.new(pledging_ends_on: 2.day.from_now)

    expect(project.pledging_expired?).to eq(false)
  end

  it "requires a name" do
    project = Project.new(name: "")

    project.valid?

    expect(project.errors[:name].any?).to eq(true)
  end

  it "requires a description" do
    project = Project.new(description: "")

    project.valid?

    expect(project.errors[:description].any?).to eq(true)
  end

  it "accepts a description up to 500 characters" do
    project = Project.new(description: "X" * 501)

    project.valid?

    expect(project.errors[:description].any?).to eq(true)
  end

  it "accepts a positive target pledge amount" do
    project = Project.new(target_pledge_amount: 5)

    project.valid?

    expect(project.errors[:target_pledge_amount].any?).to eq(false)
  end

  it "rejects a $0 target pledge amount" do
    project = Project.new(target_pledge_amount: 0)

    project.valid?

    expect(project.errors[:description].any?).to eq(true)
  end

  it "rejects a negative target pledge amount" do
    project = Project.new(target_pledge_amount: -50)

    project.valid?

    expect(project.errors[:description].any?).to eq(true)
  end

  it "accepts properly formatted website URLs" do
    project = Project.new(website: "http://www.spinlister.com")

    project.valid?

    expect(project.errors[:website].any?).to eq(false)
  end

  it "rejects improperly formatted website URLs" do
    project = Project.new(website: "hhtps;//www.spinlister.com")

    project.valid?

    expect(project.errors[:website].any?).to eq(true)
  end

  it "accepts properly formatted image file names" do
    project = Project.new(image_file_name: "toucan.png")

    project.valid?

    expect(project.errors[:image_file_name].any?).to eq(false)
  end

  it "rejects improperly formatted image file names" do
    project = Project.new(image_file_name: "toucan.bmp")

    project.valid?

    expect(project.errors[:image_file_name].any?).to eq(true)
  end

  it "has many pledges" do
    project = Project.new(project_attributes)

    pledge1 = project.pledges.new(pledge_attributes)
    pledge2 = project.pledges.new(pledge_attributes)

    expect(project.pledges).to include(pledge1)
    expect(project.pledges).to include(pledge2)
  end

  it "deletes associated pledges" do
    project = Project.create(project_attributes)

    project.pledges.create(pledge_attributes)

    expect {
      project.destroy
    }.to change(Pledge, :count).by(-1)
  end

  it "calculates the total amount pledged as the sum of all the pledges" do
    project = Project.create(project_attributes)
    plegdge = project.pledges.create(pledge_attributes(amount: 25.00))
    plegdge = project.pledges.create(pledge_attributes(amount: 50.00))

    expect(project.total_pledges).to eq(75.00)
  end

  it "calculates the pledge amount outstanding" do
    project = Project.create(project_attributes(target_pledge_amount: 100.00))
    project.pledges.create(pledge_attributes(amount: 50.00))

    expect(project.amount_outstanding).to eq(50.00)
  end

  it "is funded if the target amount has been reached" do
    project = Project.create(project_attributes(target_pledge_amount: 100.00))
    project.pledges.create(pledge_attributes(amount: 50.00))
    project.pledges.create(pledge_attributes(amount: 50.00))

    expect(project.funded?).to eq(true)
  end

  it "is not funded if the target pledge amount has not been reached" do
    project = Project.create(project_attributes(target_pledge_amount: 100.00))
    project.pledges.create(pledge_attributes(amount: 50.00))

    expect(project.funded?).to eq(false)
  end
end
