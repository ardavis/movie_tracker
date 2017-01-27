class MoviesController < ApplicationController
  def index
    @movies = if params[:query]
                current_user.movies.where("UPPER(title) LIKE UPPER(?)", "%#{params[:query]}%")
              else
                current_user.movies
              end
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
    movie = Movie.add(params[:imdb_id])

    if movie.persisted? && current_user.movies << movie
      head :ok
    else
      head :internal_server_error
    end

  end

  private

  def movie_params
    params.require(:movie).permit(:title, :date, :length)
  end
end