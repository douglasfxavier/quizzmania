class AddQuizzToTag < ActiveRecord::Migration[5.2]
  def change
    add_reference :tags, :quizz, foreign_key: true
  end
end
