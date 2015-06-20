require 'rails_helper'

describe 'Viewing an individual movie' do
  it "Shows movie's attributes" do
    movie = Movie.create(movie_attributes(title: "Ironman",
                        rating: "PG-13",
                        total_gross: 318412101.00,
                        description: "Jet-setting industrialist Tony Stark builds a high-tech suit of armor and vows to protect the world as Iron Man.",
                        released_on: "2008-05-02"))
  
    visit movie_url(movie)

    expect(page).to have_text(movie.title)
    expect(page).to have_text(movie.rating)
    expect(page).to have_text(movie.description)
    expect(page).to have_text(movie.released_on)
    expect(page).to have_text("$318,412,101.00")
  end

  it "shows the total gross if the total gross exceeds $50M" do
    movie = Movie.create(movie_attributes(total_gross: 60000000.00))

    visit movie_url(movie)

    expect(page).to have_text("$60,000,000.00")
  end

  it "shows 'Flop!' if the total gross is less than $50M" do
    movie = Movie.create(movie_attributes(total_gross: 45000000.00))

    visit movie_url(movie)

    expect(page).to have_text("Flop")
  end

  it "shows the movie's fans and genres in the sidebar" do
    movie = Movie.create!(movie_attributes)

    user = User.create!(user_attributes)
    movie.fans << user

    genre = Genre.create!(name: "Action")
    movie.genres << genre

    visit movie_url(movie)

    within("aside#sidebar") do
      expect(page).to have_text(user.name)
      expect(page).to have_text(genre.name)
    end
  end

  it "includes the movie's title in the page title" do
    movie = Movie.create!(movie_attributes)

    visit movie_url(movie)

    expect(page).to have_title("#{movie.title} (#{movie.released_on.year}) | Flix ")
  end
end
