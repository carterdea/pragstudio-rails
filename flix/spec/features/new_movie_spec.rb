require 'rails_helper'

describe "Creating a new movie" do
  before do
    user = User.create!(user_attributes(admin: true))
    sign_in(user)
    @genre1 = Genre.create!(name: "Genre 1")
    @genre2 = Genre.create!(name: "Genre 2")
    @genre3 = Genre.create!(name: "Genre 3")
  end
  it "saves the movie and shows the movie's details" do
    visit movies_url

    click_link 'Add New Movie'

    expect(current_path).to eq(new_movie_path)

    fill_in "Title", with: "New Movie Title"
    fill_in "Description", with: "Superheroes saving the world from villains"
    select "PG-13", :from => "movie_rating"
    fill_in "Total gross", with: "75000000"
    fill_in "Cast", with: "The award-winning cast"
    fill_in "Director", with: "The ever-creative director"
    fill_in "Duration", with: "123 min"
    fill_in "Image file name", with: "movie.png"
    select (Time.now.year - 1).to_s, :from => "movie_released_on_1i"
    check(@genre1.name)
    check(@genre2.name)

    click_button "Create Movie"

    expect(current_path).to eq(movie_path(Movie.last))

    expect(page).to have_text("New Movie Title")
    expect(page).to have_text("Superheroes saving the world from villains")
    expect(page).to have_text("PG-13")
    expect(page).to have_text("$75,000,000.00")
    expect(page).to have_selector("img[src$='movie.png']")
    expect(page).to have_text(@genre1.name)
    expect(page).to have_text(@genre2.name)
    expect(page).not_to have_text(@genre3.name)

    expect(page).to have_text('Movie successfully created!')
  end

  it "does not save the movie if it's invalid" do
    visit new_movie_url
    
    expect { 
      click_button 'Create Movie' 
    }.not_to change(Movie, :count)
    
    expect(current_path).to eq(movies_path)   
    expect(page).to have_text('error')
  end
end