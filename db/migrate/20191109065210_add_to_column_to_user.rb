class AddToColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_icon, :string
    add_column :users, :image_background, :string
  end
end
