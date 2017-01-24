class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.string :name

      t.timestamps
    end
  end
end
