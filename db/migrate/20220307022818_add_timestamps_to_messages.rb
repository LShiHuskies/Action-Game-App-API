class AddTimestampsToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :timestamps, :datetime
  end
end
