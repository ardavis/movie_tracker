class CreateUserMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :user_movies do |t|
      t.integer :user_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
