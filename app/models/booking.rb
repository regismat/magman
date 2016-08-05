class Booking < ActiveRecord::Base
  
  belongs_to :customer, inverse_of: :bookings
  belongs_to :item, inverse_of: :bookings
  
  
  validates_presence_of :item_id
  validates_presence_of :customer_id
  validates_presence_of :quantity
end
