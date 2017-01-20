class SearchesController < ApplicationController
  def new
  end

  def results
    query = params[:query]
    response = HTTParty.get("http://www.omdbapi.com/?s=#{query}&type=movie")
    data = JSON.parse(response.body)

    @movies = []
    data['Search'].each do |movie_result|
      new_movie = Movie.new(title: movie_result['Title'],
                           poster: movie_result['Poster'],
                           date: Date.new(movie_result['Year'].to_i))

      new_movie.imdb_id = movie_result['imdbID']

      @movies << new_movie
    end
  end
end