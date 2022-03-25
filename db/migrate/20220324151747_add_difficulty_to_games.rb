class AddDifficultyToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :difficulty, :integer
    add_column :games, :weapon, :string, :default => "Pistol"
    add_column :games, :backup_supply, :string
  end
end
