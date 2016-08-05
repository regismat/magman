class Item < ActiveRecord::Base
  
  
  has_many :deliveries, inverse_of: :item
  has_many :orders, inverse_of: :item
  
  has_many :bookings, inverse_of: :item
  has_many :customers, :through => :bookings

  accepts_nested_attributes_for :deliveries, :orders
  
  
  validates_presence_of :name
  validates_presence_of :detail
  validates_presence_of :stock
  
end
