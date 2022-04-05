class AddHealthToUserGames < ActiveRecord::Migration[5.2]
  def change
    add_column :user_games, :health, :integer
    add_column :user_games, :top, :integer
    add_column :user_games, :left, :integer
    add_column :user_games, :direction, :string
  end
end
