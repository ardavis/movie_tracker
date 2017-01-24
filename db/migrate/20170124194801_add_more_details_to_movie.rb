class AddMoreDetailsToMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :plot, :text
    add_column :movies, :metascore, :integer
    add_column :movies, :imdb_rating, :float
    add_column :movies, :imdb_votes, :integer
  end
end
