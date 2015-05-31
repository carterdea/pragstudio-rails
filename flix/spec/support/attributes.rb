def movie_attributes(overrides = {})
  {
    title: "Iron Man",
    rating: "PG-13",
    total_gross: 318412101.00,
    description: "Jet-setting industrialist Tony Stark builds a high-tech suit of armor and vows to protect the world as Iron Man.",
    released_on: "2008-05-02"
  }.merge(overrides)
end