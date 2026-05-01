class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_one :business_setting, dependent: :destroy


  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
