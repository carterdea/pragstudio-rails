def event_attributes(overrides = {})
  {
    name: "BugSmash",
    location: "Denver, CO",
    price: 10.00,
    description: 'A fun Evening of bug smashing',
    starts_at: 10.days.from_now
  }.merge(overrides)
end