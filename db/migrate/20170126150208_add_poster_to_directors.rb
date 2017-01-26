class AddPosterToDirectors < ActiveRecord::Migration[5.0]
  def change
    add_column :directors, :poster, :string
  end
end
