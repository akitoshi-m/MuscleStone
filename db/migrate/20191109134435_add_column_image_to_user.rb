class AddColumnImageToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_icon, :string
  end
end
