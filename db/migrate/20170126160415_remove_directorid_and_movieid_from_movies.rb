class RemoveDirectoridAndMovieidFromMovies < ActiveRecord::Migration[5.0]
  def change
    remove_column :movies, :director_id
    remove_column :movies, :movie_id
  end
end
