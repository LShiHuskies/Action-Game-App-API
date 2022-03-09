class RemoveTimestampsFromMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :timestamps, :datetime
  end
end
