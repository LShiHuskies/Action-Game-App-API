class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :score
      t.string :type
      t.integer :chatroom_id
      t.timestamps
    end
  end
end
