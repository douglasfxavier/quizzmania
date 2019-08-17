class AddImageToType < ActiveRecord::Migration[5.2]
  def change
    add_column :types, :image, :string
  end
end
