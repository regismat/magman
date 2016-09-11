class Booking < ActiveRecord::Base
  
  belongs_to :customer, inverse_of: :bookings
  belongs_to :item, inverse_of: :bookings
  
  
  validates :item_id, presence:{message:" non sélectionné"}
  validates :quantity, presence:{message:" ne peut être nul ni vide"},
                       numericality:{message:" ne supporte que des nombres"}           
end

