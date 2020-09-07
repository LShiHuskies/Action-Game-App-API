class RemoveChatroomFromGames < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :chatroom_id, :integer
  end
end
