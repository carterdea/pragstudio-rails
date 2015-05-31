require 'rails_helper'

describe "Navigate Movies" do

  it "allows navigation from movie list to movie detail" do
    movie = Movie.create(movie_attributes)

    visit movies_url

    click_link movie.title

    expect(current_path).to eq(movie_path(movie))
  end
  
  it "allows navigation from movie show to movie list" do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)

    click_link "All Movies"

    expect(current_path).to eq(root_path)
  end

end