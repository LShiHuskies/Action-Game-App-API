class CreateChatrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chatrooms do |t|
      t.integer :user_game_id
      t.timestamps
    end
  end
end
