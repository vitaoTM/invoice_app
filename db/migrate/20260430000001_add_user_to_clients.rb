class AddUserToClients < ActiveRecord::Migration[8.1]
  def up
    add_reference :clients, :user, null: true, foreign_key: true

    first_user_id = select_value("SELECT id FROM users ORDER BY id LIMIT 1")
    execute("UPDATE clients SET user_id = #{first_user_id} WHERE user_id IS NULL") if first_user_id

    change_column_null :clients, :user_id, false
  end

  def down
    remove_reference :clients, :user, foreign_key: true
  end
end
