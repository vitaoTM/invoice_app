class Client < ApplicationRecord
  belongs_to :user
  has_many :invoices, dependent: :restrict_with_error

  validates :name, presence: true

  def display_name
    "#{name} (#{country})"
  end
end
