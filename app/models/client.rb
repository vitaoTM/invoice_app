class Client < ApplicationRecord
  has_many :invoices, dependent: :restrict_with_error

  validates :name, presence: true

  def display_name
    "#{name} (#{country})"
  end
end
