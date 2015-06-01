class MoviesController < ApplicationController
  def index
    @movies = Movie.released
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(cleaned_params)
    redirect_to @movie
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(cleaned_params)
    @movie.save
    redirect_to @movie
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end
private
  def cleaned_params
    params.require(:movie).permit(:title, :description, :rating, :total_gross, :director, :cast, :released_on, :image_file_name, :duration)
  end
end
