class AddCafeIdToMenus < ActiveRecord::Migration[6.0]
  def change
    add_column :menus, :cafe_id, :integer
  end
end
