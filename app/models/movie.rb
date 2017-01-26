class Movie < ApplicationRecord

  # Associations
  belongs_to :rating

  has_many :movie_genres
  has_many :movie_directors
  has_many :genres, through: :movie_genres
  has_many :directors, through: :movie_directors

  # Creates getter/setters
  attr_accessor :imdb_id

  validates :title, presence: true, uniqueness: true

  def self.add(imdb_id)
    response = HTTParty.get("#{OMDB_API_URL}/?i=#{imdb_id}")
    data = JSON.parse(response.body)

    # Check if the rating already exists in the db,
    # if not, create it
    rating = Rating.where(name: data['Rated']).first_or_create


    # Initialize a new movie with data from OMDB
    new_movie = Movie.new(title: data['Title'],
                          poster: data['Poster'],
                          date: DateTime.parse(data['Released']),
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
