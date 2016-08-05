class Provider < ActiveRecord::Base
  has_many :deliveries
  
  validates_presence_of :names
  validates_presence_of :town
  validates_presence_of :telephone
  validates_presence_of :email
end
