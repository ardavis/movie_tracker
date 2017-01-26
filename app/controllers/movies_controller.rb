class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movies_path
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  # Javascript only
  def add
    new_movie = Movie.add(params[:imdb_id])

    if new_movie.save
      head :ok
    else
      head :internal_server_error
    end

  end

  def search
    @movies = Movie.where("UPPER(title) LIKE UPPER(?)", "%#{params[:query]}%")
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :date, :length)
  end
end