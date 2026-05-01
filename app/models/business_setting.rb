class BusinessSetting < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :currency, presence: true

  def self.for(user)
    user.business_setting || user.create_business_setting!(
      name: "My Business",
      currency: "USD",
      payment_terms_days: 15
    )
  end

  def full_registration
    "#{registration_label}: #{registration_number}"
  end
end
