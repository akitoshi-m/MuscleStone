class ArrangeColumnToMenus < ActiveRecord::Migration[5.2]
  def change
    add_column :menus, :user_id, :integer
    
    remove_column :menus, :use_id, :integer
  end
end
