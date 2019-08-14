class AddQuizzToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :quizz, foreign_key: true
  end
end
