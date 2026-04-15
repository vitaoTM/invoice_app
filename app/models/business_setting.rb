class BusinessSetting < ApplicationRecord
  validates :name, presence: true
  validates :currency, presence: true

  # Singleton accessor — always returns the one company record
  def self.current
    first_or_create!(
      name: "Personal Concierge & Tours",
      tagline: "Aruba Tourist Services",
      address: "Oranjestad, Aruba",
      registration_number: "H42115.0",
      registration_label: "KvK Aruba",
      currency: "USD",
      payment_terms_days: 15
    )
  end

  def full_registration
    "#{registration_label}: #{registration_number}"
  end
end
