class CreateBusinessSettings < ActiveRecord::Migration[8.1]
  def change
    create_table :business_settings do |t|
      t.string :name, null: false, default: "Personal Concierge & Tours"
      t.string :tagline, default: "Aruba Tourist Services"
      t.string :address, default: "Oranjestad, Aruba"
      t.string :registration_number, default: "H42115.0"
      t.string :registration_label, default: "KvK Aruba"
      t.string :phone
      t.string :email
      t.string :currency, default: "USD"
      t.integer :payment_terms_days, default: 15
      t.text :footer_note

      t.timestamps
    end
  end
end
