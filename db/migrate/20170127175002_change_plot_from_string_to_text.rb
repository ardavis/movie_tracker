class ChangePlotFromStringToText < ActiveRecord::Migration[5.0]
  def change
    change_column :movies, :plot, :text
  end
end
