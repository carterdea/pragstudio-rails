# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Event.create!([
  {
    name: 'BugSmash',
    location: 'Denver, CO',
    price: 0.00,
    description: 'A fun evening of bug smashing!',
    starts_at: 100.days.from.now
  },
  {
    name: 'Hackathon',
    location: 'Austin, TX',
    price: 15.00,
    description: 'Hunker down at the Hackathon!',
    starts_at: 120.days.from_now
  },
  {
    name: 'Kata Camp',
    location: 'Dallas, TX',
    price: 75.00,
    description: 'Kata Camp is where developers go to practice their code kata style.',
    starts_at: 150.days.from_now
  }
])
