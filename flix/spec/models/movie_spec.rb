require 'rails_helper'

describe "a movie" do
  it "is a flop if the total gross is less than $50M" do
    movie = Movie.new(total_gross: 40000000.00)

    expect(movie.flop?).to eq(true)
  end

  it "is a flop if the total gross is blank" do
    movie = Movie.new(total_gross: nil)

    expect(movie.flop?).to eq(true)
  end

  it "requires a title" do
    movie = Movie.new(title: "")

    movie.valid?  # populates errors

    expect(movie.errors[:title].any?).to eq(true)
  end

  it "requires a description" do
    movie = Movie.new(description: "")

    movie.valid?

    expect(movie.errors[:description].any?).to eq(true)
  end

  it "requires a released on date" do
    movie = Movie.new(released_on: "")

    movie.valid?

    expect(movie.errors[:released_on].any?).to eq(true)
  end

  it "requires a duration" do
    movie = Movie.new(duration: "")

    movie.valid?

    expect(movie.errors[:duration].any?).to eq(true)
  end

  it "requires a description over 24 characters" do
    movie = Movie.new(description: "X" * 24)

    movie.valid?

    expect(movie.errors[:description].any?).to eq(true)
  end

  it "accepts a $0 total gross" do
    movie = Movie.new(total_gross: 0.00)

    movie.valid?

    expect(movie.errors[:total_gross].any?).to eq(false)
  end

  it "accepts a positive total gross" do
    movie = Movie.new(total_gross: 10000000.00)

    movie.valid?

    expect(movie.errors[:total_gross].any?).to eq(false)
  end

  it "rejects a negative total gross" do
    movie = Movie.new(total_gross: -10000000.00)

    movie.valid?

    expect(movie.errors[:total_gross].any?).to eq(true)
  end

  it "accepts properly formatted image file names" do
    file_names = %w[e.png movie.png movie.jpg movie.gif MOVIE.GIF]
    file_names.each do |file_name|
      movie = Movie.new(image_file_name: file_name)
      movie.valid?
      expect(movie.errors[:image_file_name].any?).to eq(false)
    end
  end

  it "rejects improperly formatted image file names" do
    file_names = %w[movie .jpg .png .gif movie.pdf movie.doc]
    file_names.each do |file_name|
      movie = Movie.new(image_file_name: file_name)
      movie.valid?
      expect(movie.errors[:image_file_name].any?).to eq(true)
    end
  end

  it "accepts any rating that is in an approved list" do
    ratings = %w[G PG PG-13 R NC-17]
    ratings.each do |rating|
      movie = Movie.new(rating: rating)
      movie.valid?
      expect(movie.errors[:rating].any?).to eq(false)
    end
  end

  it "rejects any rating that is not in the approved list" do
    ratings = %w[R-13 R-16 R-18 R-21]
    ratings.each do |rating|
      movie = Movie.new(rating: rating)
      movie.valid?
      expect(movie.errors[:rating].any?).to eq(true)
    end
  end

  it "is valid with example attributes" do
    movie = Movie.new(movie_attributes)

    expect(movie.valid?).to eq(true)
  end

  it "calculates the average number of review stars" do
    movie = Movie.create(movie_attributes)

    movie.reviews.create(review_attributes(stars: 1))
    movie.reviews.create(review_attributes(stars: 3))
    movie.reviews.create(review_attributes(stars: 5))
    
    expect(movie.average_stars).to eq(3)
  end

  it "has fans" do
    movie = Movie.new(movie_attributes)
    fan1 = User.new(user_attributes(email: "larry@example.com"))
    fan2 = User.new(user_attributes(email: "moe@example.com"))

    movie.favorites.new(user: fan1)
    movie.favorites.new(user: fan2)

    expect(movie.fans).to include(fan1)
    expect(movie.fans).to include(fan2)
  end

  it "generates a slug when it's created" do
    movie = Movie.create!(movie_attributes(title: "X-Men: The Last Stand"))

    expect(movie.slug).to eq("x-men-the-last-stand")
  end

  it "requires a unique title" do
    movie1 = Movie.create!(movie_attributes)

    movie2 = Movie.new(title: movie1.title)
    movie2.valid? # populates errors
    expect(movie2.errors[:title].first).to eq("has already been taken")
  end

  it "requires a unique slug" do
    movie1 = Movie.create!(movie_attributes)

    movie2 = Movie.new(slug: movie1.slug)
    movie2.valid? # populates errors
    expect(movie2.errors[:slug].first).to eq("has already been taken")
  end
end