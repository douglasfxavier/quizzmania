class AddTagToChoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :choices, :tag, foreign_key: true
  end
end
