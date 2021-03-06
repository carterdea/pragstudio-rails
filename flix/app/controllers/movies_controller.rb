class MoviesController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.send(movies_scope)
  end

  def show
    @fans = @movie.fans
    @genres = @movie.genres
    if current_user
      @current_favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
  end

  def edit
    
  end

  def update
    if @movie.update(cleaned_params)
      redirect_to @movie, notice: "Movie successfully updated!"
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(cleaned_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created!"
    else
      render :new
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, alert: "Movie successfully deleted!"
  end

  def movies_scope
    if params[:scope].in? %w(hits flops upcoming recent)
      params[:scope]
    else
      :released
    end
  end

private
  def cleaned_params
    params.require(:movie).permit(:title, :description, :rating, :total_gross, :director, :cast, :released_on, :image_file_name, :duration, :slug, genre_ids: [])
  end

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
  end
end
