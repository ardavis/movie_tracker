class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.datetime :date
      t.integer :length

      t.timestamps
    end
  end
end
