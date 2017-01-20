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

  def add
    imdb_id = params[:imdb_id]
    response = HTTParty.get("http://www.omdbapi.com/?i=#{imdb_id}")
    data = JSON.parse(response.body)

    new_movie = Movie.new(title: data['Title'],
              poster: data['Poster'],
              date: DateTime.parse(data['Released']),
              length: data['Runtime'].to_i)

    if new_movie.save
      flash[:notice] = 'Movie added!'
    else
      flash[:alert] = 'Unable to add movie... :('
    end
    redirect_to :back
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :date, :length)
  end
end