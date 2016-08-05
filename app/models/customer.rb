class Customer < ActiveRecord::Base
  has_one :user
  #has_one :cart
  belongs_to :department
  has_many :orders
  
  has_many :bookings, inverse_of: :customer
  has_many :items, :through=>:bookings
  has_many :deliveries
  validates_presence_of :names
  validates_presence_of :telephone
  validates_presence_of :department_id
  
end
