class DropJwtDenylists < ActiveRecord::Migration[6.0]
  def change
    drop_table :jwt_user_denylists
  end
end
