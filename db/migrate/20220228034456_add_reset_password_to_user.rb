class AddResetPasswordToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_at, :datetime
    add_column :users, :admin, :boolean, default: false
  end
end
