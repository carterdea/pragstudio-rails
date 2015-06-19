require 'rails_helper'

describe "Unfavoriting a movie" do
  before do
    @user = User.create!(user_attributes)
    sign_in(@user)
  end

  it "deletes the favorite and shows the Favorite button" do
    movie = Movie.create!(movie_attributes)

    visit movie_url(movie)
    click_button 'Favorite'

    expect(page).to have_text("1 Fan")

    expect {
      click_button 'Unfavorite'
    }.to change(@user.favorites, :count).by(-1)

    expect(current_path).to eq(movie_path(movie))

    expect(page).to have_text("Successfully unfavorited")
    expect(page).to have_button("Favorite")
  end
end