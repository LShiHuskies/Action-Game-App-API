class AddAcceptedToUserGames < ActiveRecord::Migration[5.2]
  def change
    add_column :user_games, :accepted, :boolean
  end
end
