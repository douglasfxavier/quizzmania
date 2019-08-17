class AddImageToQuizz < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzs, :image, :string
  end
end
