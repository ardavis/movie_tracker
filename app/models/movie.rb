class Movie < ApplicationRecord

  # Creates getter/setters
  attr_accessor :imdb_id

  validates :title, presence: true
end
