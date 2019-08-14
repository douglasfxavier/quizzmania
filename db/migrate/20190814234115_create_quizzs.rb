class CreateQuizzs < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzs do |t|
      t.string :description
      t.references :type, foreign_key: true

      t.timestamps
    end
  end
end
