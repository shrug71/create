class AddUserIdToCafes < ActiveRecord::Migration[6.0]
  def change
    add_column :caves, :user_id, :integer
    add_index :caves, :user_id
  end
end
