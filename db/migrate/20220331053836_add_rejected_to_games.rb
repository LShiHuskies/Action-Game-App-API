class AddRejectedToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :rejected, :boolean
  end
end
