require 'rails_helper'
describe "Navigating events" do
  it "allows navigation from detail page to listing page" do
    event = Event.create(event_attributes)

    visit event_url(event)

    click_link "All Events"

    expect(current_path).to eq(events_path)
  end

  it "allows navigation from listing page to detail page" do
    event = Event.create(event_attributes)    

    visit events_url

    click_link "BugSmash"

    expect(current_path).to eq(event_path(event))
  end

end