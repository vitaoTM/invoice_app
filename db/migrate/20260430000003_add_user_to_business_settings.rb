class AddUserToBusinessSettings < ActiveRecord::Migration[8.1]
  def up
    add_reference :business_settings, :user, null: true, foreign_key: true

    first_user_id = select_value("SELECT id FROM users ORDER BY id LIMIT 1")
    execute("UPDATE business_settings SET user_id = #{first_user_id} WHERE user_id IS NULL") if first_user_id

    change_column_null :business_settings, :user_id, false
  end

  def down
    remove_reference :business_settings, :user, foreign_key: true
  end
end
