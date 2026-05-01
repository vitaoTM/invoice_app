class AddUserToBusinessSettings < ActiveRecord::Migration[8.1]
  def change
    add_reference :business_settings, :user, null: false, foreign_key: true
  end
end
