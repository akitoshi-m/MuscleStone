class RemoveColumnToUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :image_icon, :string
    remove_column :users, :image_background, :string
  end
end
