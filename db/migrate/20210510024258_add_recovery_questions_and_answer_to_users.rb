class AddRecoveryQuestionsAndAnswerToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :recovery_question, :string
    add_column :users, :recovery_answer_digest, :string
  end
end
