class Order < ActiveRecord::Base
  
  belongs_to :item, inverse_of: :orders
  belongs_to :customer
  
  validates_presence_of :date
  validates_presence_of :quantity
  validates_presence_of :item_id
  validates_presence_of :customer_id
  
end
