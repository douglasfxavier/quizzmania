class RemoveAnswersFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_reference :users, :answers, foreign_key: true
  end
end
