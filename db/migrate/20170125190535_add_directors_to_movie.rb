class AddDirectorsToMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :director_id, :integer
    add_column :movies, :movie_id, :integer
  end
end
