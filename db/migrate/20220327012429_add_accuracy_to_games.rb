class AddAccuracyToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :accuracy, :float
  end
end
