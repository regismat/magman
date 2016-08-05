class Delivery < ActiveRecord::Base
  
  belongs_to :item, inverse_of: :deliveries
  belongs_to :provider
  belongs_to :customer
 
  validates_presence_of :date
  validates_presence_of :quantity
  validates_presence_of :price
  validates_presence_of :item_id
  validates_presence_of :provider_id
  validates_presence_of :customer_id
  validates_presence_of :reference
  
end
