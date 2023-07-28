class PhoneNumber < ApplicationRecord
  belongs_to :guest, inverse_of: :phone_numbers

  validates :number, presence: true, uniqueness: { scope: :guest_id }

end
