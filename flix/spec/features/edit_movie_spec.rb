require 'rails_helper'

describe "editing a movie" do
  it "updates a movie and shows the movie's updated details" do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)

    click_link "Edit"

    expect(current_path).to eq(edit_movie_path(movie))

    expect(find_field('Title').value).to eq(movie.title)

    fill_in 'Title', with: "Updated Movie Title"

    click_button 'Save Changes'

    expect(current_path).to eq(movie_path(movie))

    expect(page).to have_text('Updated Movie Title')
  end
end