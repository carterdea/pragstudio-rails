require 'rails_helper'

describe "Deleting a movie" do
  it "destroys the movie and shows the movie listing without the deleted movie" do
    user = User.create!(user_attributes(admin: true))
    movie = Movie.create(movie_attributes)
    sign_in(user)
    visit movie_path(movie)

    click_link 'Delete'

    expect(current_path).to eq(movies_path)
    expect(page).not_to have_text(movie.title)
  end
end