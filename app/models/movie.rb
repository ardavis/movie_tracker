class Movie < ApplicationRecord

  # Associations
  belongs_to :rating

  has_many :movie_genres
  has_many :movie_directors
  has_many :user_movies
  has_many :genres, through: :movie_genres
  has_many :directors, through: :movie_directors
  has_many :users, through: :user_movies

  # Creates getter/setters
  # attr_accessor :imdb_id # No longer needed now that it's a column in the db

  validates :imdb_id, uniqueness: true
  validates :title, presence: true

  def self.add(imdb_id)
    # Return the movie if it already exists
    existing_movie = Movie.find_by(imdb_id: imdb_id)
    return existing_movie if existing_movie

    response = HTTParty.get("#{OMDB_API_URL}/?i=#{imdb_id}")
    data = JSON.parse(response.body)

    # Check if the rating already exists in the db,
    # if not, create it
    rating = Rating.where(name: data['Rated']).first_or_create


    # Initialize a new movie with data from OMDB
    released_date = data['Released'] == 'N/A' ? nil : DateTime.parse(data['Released'])

    new_movie = Movie.new(imdb_id: imdb_id,
                          title: data['Title'],
                          poster: data['Poster'],
                          date: released_date,
                          length: data['Runtime'].to_i,
                          rating: rating,
                          plot: data['Plot'],
                          metascore: data['Metascore'].to_i,
                          imdb_rating: data['imdbRating'].to_f,
                          imdb_votes: data['imdbVotes'].to_i
    )

    # Split up the genres and add them to the movie
    data['Genre'].split(', ').each do |genre_name|
      genre = Genre.where(name: genre_name).first_or_create
      new_movie.genres << genre
    end

    data['Director'].split(', ').each do |director_name|
      director = Director.where(name: director_name).first_or_create
      new_movie.directors << director
    end

    new_movie.save
    new_movie
  end

  def display_name
    "#{title} (#{rating.name})"
  end

  def genre_names
    genres.collect(&:name).join(', ')
  end

  def imdb_results
    "#{imdb_rating} (#{imdb_votes} votes)"
  end

  #def director_names
  #  names = 'Director'
  #  if directors.size > 1
  #    names = names + 's'
  #  end
  #  names + ': ' + directors.collect(&:name).join(', ')
  #end
end
