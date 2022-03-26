class RemoveTypeFromGame < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :type, :string
  end
end
